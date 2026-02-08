(define (minimize-max-diff-pairs nums p)
  (define (check mid)
    (let loop ([i 0] [count 0])
      (cond
        [(>= i (sub1 (length nums))) count]
        [(= count p) #t]
        [(<= (- (list-ref nums (+ i 1)) (list-ref nums i)) mid) (loop (+ i 2) (+ count 1))]
        [else (loop (+ i 1) count)])))

  (let ([sorted-nums (sort nums <)])
    (let loop ([left 0] [right (- (list-ref sorted-nums (sub1 (length sorted-nums))) (list-ref sorted-nums 0))])
      (if (<= left right)
          (let ([mid (quotient (+ left right) 2)])
            (if (check mid)
                (loop left (sub1 mid))
                (loop (+ mid 1) right)))
          left))))