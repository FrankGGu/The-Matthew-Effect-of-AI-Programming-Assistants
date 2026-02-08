(define (min-moves nums limit)
  (let* ([n (length nums)]
         [delta (make-hash)]
         [res +inf.0])
    (for ([i (in-range (/ n 2))])
      (let* ([a (list-ref nums i)]
             [b (list-ref nums (- n 1 i))]
             [sum (+ a b)]
             [min-val (min a b)]
             [max-val (max a b)])
      (hash-update! delta 2 (lambda (v) (+ v 1)) 0)
      (hash-update! delta (+ min-val 1) (lambda (v) (- v 1)) 0)
      (hash-update! delta sum (lambda (v) (- v 1)) 0)
      (hash-update! delta (+ sum 1) (lambda (v) (+ v 1)) 0)
      (hash-update! delta (+ max-val limit 1) (lambda (v) (+ v 1)) 0))
    (let ([current 0])
      (for ([s (in-range 2 (+ (* 2 limit) 1))])
        (set! current (+ current (hash-ref delta s 0)))
        (set! res (min res current)))
    res))