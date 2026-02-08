(define (breakfast-number count-list price-list x)
  (define (count-less-equal lst val)
    (let loop ([lst lst] [count 0])
      (cond
        [(empty? lst) count]
        [(<= (car lst) val) (loop (cdr lst) (+ count 1))]
        [else (loop (cdr lst) count)])))

  (define sorted-price-list (sort price-list <))
  (let loop ([i 0] [count 0])
    (if (= i (length count-list))
        (modulo count 1000000007)
        (let ([sandwich-price (list-ref count-list i)])
          (set! count (+ count (count-less-equal sorted-price-list (- x sandwich-price))))
          (loop (+ i 1) count)))))