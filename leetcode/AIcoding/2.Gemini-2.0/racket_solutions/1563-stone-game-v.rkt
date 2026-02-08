(define (stone-game-v stones)
  (define n (length stones))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum i) (list-ref stones i))))

  (define memo (make-hash))

  (define (solve left right)
    (cond
      [(>= left right) 0]
      [(hash-has-key? memo (cons left right)) (hash-ref memo (cons left right))]
      [else
       (let loop ([x (+ left 1)] [max-score 0])
         (cond
           [(> x right) max-score]
           [else
            (let* ([left-sum (- (vector-ref prefix-sum x) (vector-ref prefix-sum left))]
                   [right-sum (- (vector-ref prefix-sum (+ right 1)) (vector-ref prefix-sum x))]
                   [score
                    (cond
                      [(< left-sum right-sum) (+ left-sum (solve left (- x 1)))]
                      [(> left-sum right-sum) (+ right-sum (solve x right))]
                      [else (max (+ left-sum (solve left (- x 1))) (+ right-sum (solve x right)))])])
              (loop (+ x 1) (max max-score score))))]))

  (let ([result (solve 0 (- n 1))])
    (hash-set! memo (cons 0 (- n 1)) result)
    result))