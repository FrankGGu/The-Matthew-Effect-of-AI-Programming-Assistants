#lang racket

(define (count-k-subsequences-with-maximum-beauty s k)
  ;; Helper function to calculate combinations C(n, r)
  (define (combinations n r)
    (cond
      ((< r 0) 0)
      ((> r n) 0)
      ((= r 0) 1)
      ((= r n) 1)
      (else
       ;; Use the property C(n, r) = C(n, n-r) to reduce computation if r > n/2
       (let ((r-prime (min r (- n r))))
         (let loop ((i 0) (res 1))
           (if (= i r-prime)
               res
               (loop (+ i 1)
                     (/ (* res (- n i)) (+ i 1)))))))))

  ;; 1. Calculate character frequencies
  (let ((freq-map (make-hash)))
    (for-each
     (lambda (char)
       (hash-update! freq-map char (lambda (v) (+ v 1)) 0))
     (string->list s))

    ;; 2. Get distinct character frequencies
    (let ((freqs (hash-values freq-map)))
      ;; If there are fewer distinct characters than k, it's impossible to form a K-subsequence.
      (if (< (length freqs) k)
          0
          (let* ((sorted-freqs (sort freqs >))
                 ;; 4. The k-th frequency (0-indexed k-1) determines the minimum frequency
                 ;; that a character must have to be part of a maximum beauty subsequence.
                 (min-freq-in-top-k (list-ref sorted-freqs (- k 1)))
                 ;; Count characters with frequency strictly greater than min-freq-in-top-k.
                 ;; These characters *must* be included in any maximum beauty subsequence.
                 (count-greater (count (lambda (f) (> f min-freq-in-top-k)) sorted-freqs))
                 ;; Count characters with frequency exactly equal to min-freq-in-top-k.
                 ;; We need to choose some of these to complete the k characters.
                 (count-equal (count (lambda (f) (= f min-freq-in-top-k)) sorted-freqs))
                 ;; Calculate how many more characters we need to pick from the 'count-equal' group.
                 (needed-from-equal (- k count-greater)))
            ;; 5. The number of ways is the combinations of choosing 'needed-from-equal'
            ;; characters from the 'count-equal' characters.
            (combinations count-equal needed-from-equal))))))