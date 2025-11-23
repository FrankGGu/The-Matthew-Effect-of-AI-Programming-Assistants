#lang racket

(require racket/vector)
(require racket/control)

(define (find-string-with-lcp lcp)
  (let/ec return-failure
    (let* ((n (vector-length lcp))
           (parent (make-vector n (lambda (idx) idx)))
           (chars (make-vector n #\null)))

      (define (find i)
        (if (= (vector-ref parent i) i)
            i
            (let ((root (find (vector-ref parent i))))
              (vector-set! parent i root)
              root)))

      (define (union i j)
        (let ((root-i (find i))
              (root-j (find j)))
          (cond
            ((= root-i root-j) #t)
            (else
             (let ((char-i (vector-ref chars root-i))
                   (char-j (vector-ref chars root-j)))
               (cond
                 ((and (char? char-i) (char? char-j) (not (char=? char-i char-j)))
                  #f)
                 ((char? char-i)
                  (vector-set! parent root-j root-i)
                  #t)
                 ((char? char-j)
                  (vector-set! parent root-i root-j)
                  #t)
                 (else
                  (vector-set! parent root-j root-i)
                  #t)))))))

      (for* ([i (in-range n)]
             [j (in-range n)])
        (when (and (not (= i j)) (< (+ i 1) n) (< (+ j 1) n))
          (let ((val-ij (vector-ref (vector-ref lcp i) j)))
            (when (> val-ij 0)
              (unless (= (vector-ref (vector-ref lcp (+ i 1)) (+ j 1)) (- val-ij 1))
                (return-failure ""))))))

      (for* ([i (in-range n)]
             [j (in-range (+ i 1) n)])
        (when (> (vector-ref (vector-ref lcp i) j) 0)
          (unless (union i j)
            (return-failure ""))))

      (let ((next-char-code (char->integer #\a)))
        (for ([i (in-range n)])
          (let ((root-i (find i)))
            (unless (char? (vector-ref chars root-i))
              (when (> next-char-code (char->integer #\z))
                (return-failure ""))
              (vector-set! chars root-i (integer->char next-char-code))
              (set! next-char-code (+ next-char-code 1))))))

      (let ((s-result (make-string n)))
        (for ([i (in-range n)])
          (string-set! s-result i (vector-ref chars (find i))))

        (let ((calculated-lcp (make-vector n (lambda (idx) (make-vector n 0)))))
          (for ([i (in-range (- n 1) -1 -1)])
            (for ([j (in-range (- n 1) -1 -1)])
              (cond
                ((= i j)
                 (vector-set! (vector-ref calculated-lcp i) j n))
                ((char=? (string-ref s-result i) (string-ref s-result j))
                 (vector-set! (vector-ref calculated-lcp i) j
                              (+ 1 (if (and (< (+ i 1) n) (< (+ j 1) n))
                                       (vector-ref (vector-ref calculated-lcp (+ i 1)) (+ j 1))
                                       0))))
                (else
                 (vector-set! (vector-ref calculated-lcp i) j 0)))))

          (for* ([i (in-range n)]
                 [j (in-range n)])
            (unless (= (vector-ref (vector-ref calculated-lcp i) j) (vector-ref (vector-ref lcp i) j))
              (return-failure "")))

          s-result))))))