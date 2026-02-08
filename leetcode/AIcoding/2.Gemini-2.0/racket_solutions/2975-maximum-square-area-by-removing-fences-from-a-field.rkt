(define (max-square-area height horizontal vertical)
  (define (sorted-unique lst)
    (let loop ([lst (sort lst <)] [acc '()])
      (cond
        [(empty? lst) (reverse acc)]
        [(empty? acc) (loop (cdr lst) (list (car lst)))]
        [(= (car lst) (car acc)) (loop (cdr lst) acc)]
        [else (loop (cdr lst) (cons (car lst) acc))])))

  (define (distances lst)
    (let loop ([lst (cdr lst)] [prev (car lst)] [acc '()])
      (cond
        [(empty? lst) (reverse acc)]
        [else (loop (cdr lst) (car lst) (cons (- (car lst) prev) acc))])))

  (define heights (sorted-unique (append height '(0 1000000000))))
  (define horizontals (sorted-unique (append horizontal '(0 1000000000))))

  (define height-distances (distances heights))
  (define horizontal-distances (distances horizontals))

  (define (max-common-distance dists1 dists2)
    (let loop ([dists1 dists1] [max-area 0])
      (cond
        [(empty? dists1) max-area]
        [else
         (if (member? (car dists1) dists2)
             (loop (cdr dists1) (max max-area (* (car dists1) (car dists1))))
             (loop (cdr dists1) max-area))])))

  (let ([area (max-common-distance height-distances horizontal-distances)])
    (if (= area 0)
        -1
        (modulo area (+ 1 (expt 10 9))))))