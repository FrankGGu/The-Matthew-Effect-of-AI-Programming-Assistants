(define/contract (shortest-to-char s c)
  (-> string? char? (listof exact-integer?))
  (let* ([n (string-length s)]
         [target-positions (for/list ([i (in-range n)]
                                      #:when (char=? (string-ref s i) c))
                             i)]
         [result (make-list n +inf.0)])
    (for ([pos target-positions])
      (for ([i (in-range n)])
        (let ([dist (abs (- i pos))])
          (when (< dist (list-ref result i))
            (list-set! result i dist)))))
    result)