#lang racket

(define (get-char-run-lengths s)
  (let* ((n (string-length s))
         (char-runs (make-hash)))
    (when (> n 0)
      (let loop ((i 0) (current-char (string-ref s 0)) (current-len 0))
        (if (= i n)
            ;; End of string, add last run
            (hash-set! char-runs current-char
                       (cons current-len (hash-ref char-runs current-char (list))))
            ;; Process current char
            (let ((char-at-i (string-ref s i)))
              (if (char=? char-at-i current-char)
                  (loop (+ i 1) current-char (+ current-len 1))
                  ;; Char changed, add previous run and start new
                  (begin
                    (hash-set! char-runs current-char
                               (cons current-len (hash-ref char-runs current-char (list))))
                    (loop (+ i 1) char-at-i 1)))))))
    char-runs))

(define (find-longest-special-substring-that-occurs-thrice-i s)
  (let* ((n (string-length s))
         (char-run-lengths (get-char-run-lengths s))
         (max-overall-k -1))

    (define (check k Ls-sorted)
      (let loop ((ls Ls-sorted) (total-count 0))
        (if (null? ls)
            (>= total-count 3)
            (let ((L (car ls)))
              (if (>= L k)
                  (loop (cdr ls) (+ total-count (- L k -1)))
                  ;; Optimization: if L < k, then all subsequent L's (which are smaller or equal) will also be < k.
                  ;; So no more contributions. Just check if we already have enough.
                  (>= total-count 3))))))

    (hash-for-each
     (lambda (ch Ls)
       (let* ((Ls-sorted (sort Ls >)) ; Sort in descending order
              (L1 (if (null? Ls-sorted) 0 (car Ls-sorted))) ; Max run length for this char
              (current-max-k-for-char -1))

         ;; Binary search for k for this character
         ;; Search range for k is [1, L1]
         (let loop-bs ((low 1) (high L1))
           (when (<= low high)
             (let ((mid (quotient (+ low high) 2)))
               (if (check mid Ls-sorted)
                   (begin
                     (set! current-max-k-for-char mid)
                     (loop-bs (+ mid 1) high)) ; Try for a larger k
                   (loop-bs low (- mid 1))))))) ; mid is too large, try smaller
         (set! max-overall-k (max max-overall-k current-max-k-for-char))))
     char-run-lengths)

    max-overall-k))