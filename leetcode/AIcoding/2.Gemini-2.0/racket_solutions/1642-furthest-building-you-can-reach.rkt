(define (furthest-building heights bricks ladders)
  (define (search start)
    (let loop ([i start] [bricks-used 0] [ladders-used 0] [jumps '()])
      (cond
        [(>= i (length heights)) i]
        [else
         (let ([diff (- (list-ref heights i) (list-ref heights (- i 1)))])
           (cond
             [(<= diff 0) (loop (+ i 1) bricks-used ladders-used jumps)]
             [else
              (cond
                [(>= bricks-used (+ diff))
                 (loop (+ i 1) (+ bricks-used diff) ladders-used jumps)]
                [(< ladders-used ladders)
                 (if (null? jumps)
                     (loop (+ i 1) bricks-used (+ ladders-used 1) (cons diff jumps))
                     (let ([min-jump (apply min jumps)])
                       (if (> diff min-jump)
                           (if (>= bricks-used (+ min-jump))
                               (loop (+ i 1) (+ bricks-used min-jump) (+ ladders-used 1) (remq min-jump (cons diff jumps)))
                               i)
                           (loop (+ i 1) bricks-used (+ ladders-used 1) (cons diff jumps)))))
                 ]
                [else i])])])])))
  (if (= (length heights) 1)
      0
      (search 1)))