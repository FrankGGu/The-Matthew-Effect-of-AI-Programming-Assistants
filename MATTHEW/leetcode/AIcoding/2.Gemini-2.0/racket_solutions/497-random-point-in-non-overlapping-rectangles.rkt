(define (rects->points rects)
  (let loop ([rects rects] [points '()])
    (if (null? rects)
        points
        (let* ([rect (car rects)]
               [x1 (list-ref rect 0)]
               [y1 (list-ref rect 1)]
               [x2 (list-ref rect 2)]
               [y2 (list-ref rect 3)]
               [width (+ 1 (- x2 x1))]
               [height (+ 1 (- y2 y1))]
               [num-points (* width height)])
          (loop (cdr rects) (cons (list rect num-points) points))))))

(define (prefix-sum points)
  (let loop ([points points] [acc 0] [result '()])
    (if (null? points)
        (reverse result)
        (let* ([point (car points)]
               [num-points (list-ref point 1)]
               [new-acc (+ acc num-points)])
          (loop (cdr points) new-acc (cons (list (car point) new-acc) result))))))

(define (binary-search target prefix-sum)
  (let loop ([left 0] [right (- (length prefix-sum) 1)])
    (if (> left right)
        left
        (let* ([mid (floor (/ (+ left right) 2))]
               [val (list-ref (list-ref prefix-sum mid) 1)])
          (cond
            [(< val target) (loop (+ mid 1) right)]
            [else (loop left (- mid 1))])))))

(define (random-point rects)
  (let* ([points (rects->points rects)]
         [prefix-sum (prefix-sum points)]
         [total-points (list-ref (list-ref (last prefix-sum) 1) 1)]
         [random-num (random total-points)]
         [index (binary-search (+ random-num 1) prefix-sum)]
         [rect (car (list-ref prefix-sum index))]
         [x1 (list-ref rect 0)]
         [y1 (list-ref rect 1)]
         [x2 (list-ref rect 2)]
         [y2 (list-ref rect 3)]
         [width (+ 1 (- x2 x1))]
         [height (+ 1 (- y2 y1))]
         [x (+ x1 (random width))]
         [y (+ y1 (random height))])
    (list x y)))

(struct Solution (rects) #:mutable #:prefab)

(define (Solution rects)
  (struct-copy Solution (Solution rects) [rects rects]))

(define (Solution->pick Solution)
  (random-point (Solution-rects Solution)))