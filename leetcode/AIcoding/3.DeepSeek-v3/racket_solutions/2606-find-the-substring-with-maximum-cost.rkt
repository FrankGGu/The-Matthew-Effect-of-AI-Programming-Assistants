(define (maximum-cost-substring s chars vals)
  (let* ([n (string-length s)]
         [cost (make-hash)]
         [default-val (lambda (c) (- (char->integer c) (char->integer #\a) 1))]
         [max-cost 0]
         [current 0])
    (for ([i (in-range (string-length chars))])
      (hash-set! cost (string-ref chars i) (list-ref vals i)))
    (for ([i (in-range n)])
      (let* ([c (string-ref s i)]
             [val (if (hash-has-key? cost c) (hash-ref cost c) (default-val c)])
        (set! current (max val (+ current val)))
        (set! max-cost (max max-cost current))))
    (max 0 max-cost)))