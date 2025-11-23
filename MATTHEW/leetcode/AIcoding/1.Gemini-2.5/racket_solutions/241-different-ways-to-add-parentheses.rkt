(define (diffWaysToCompute expression)
  (define memo (make-hash))

  (define (compute-memoized s)
    (hash-ref! memo s
               (lambda ()
                 (let ([results '()])
                   (for ([i (range (string-length s))])
                     (let ([char (string-ref s i)])
                       (when (or (char=? char #\+)
                                 (char=? char #\-)
                                 (char=? char #\*))
                         (let* ([left-part (substring s 0 i)]
                                [right-part (substring s (+ i 1) (string-length s))]
                                [left-vals (compute-memoized left-part)]
                                [right-vals (compute-memoized right-part)])
                           (for ([l left-vals])
                             (for ([r right-vals])
                               (case char
                                 [(#\+) (set! results (cons (+ l r) results))]
                                 [(#\-) (set! results (cons (- l r) results))]
                                 [(#\*) (set! results (cons (* l r) results))])))))))
                   (if (empty? results)
                       (list (string->number s))
                       results)))))
  (compute-memoized expression))