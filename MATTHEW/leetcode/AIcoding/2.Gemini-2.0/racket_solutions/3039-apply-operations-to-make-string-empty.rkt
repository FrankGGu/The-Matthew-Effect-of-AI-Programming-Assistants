(define (make-string-empty s)
  (let* ([n (string-length s)]
         [indices (list->vector (range n))]
         [freq (make-vector 26 0)])
    (for ([i (in-range n)])
      (vector-set! freq (- (char->integer (string-ref s i)) (char->integer #\a)) (+ (vector-ref freq (- (char->integer (string-ref s i)) (char->integer #\a))) 1)))
    (let loop ([indices (list->list indices)]
               [s (string->list s)])
      (cond
        [(null? indices) #t]
        [else
         (let* ([min-index (apply min indices)]
                [min-char (list-ref s min-index)]
                [new-indices (filter (lambda (i) (not (equal? (list-ref s i) min-char))) indices)]
                [new-s (filter (lambda (c) (not (equal? c min-char))) s)])
           (loop new-indices new-s))])))
  )