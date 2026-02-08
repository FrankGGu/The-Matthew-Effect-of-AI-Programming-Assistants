(define (can-partition nums)
  (let* ([total-product (apply * nums)]
         [n (length nums)]
         [target (sqrt total-product)])
    (if (not (integer? target))
        #f
        (let loop ([i 0] [current-product 1])
          (cond
            [(= current-product target) #t]
            [(>= i n) #f]
            [else (or (loop (+ i 1) (* current-product (list-ref nums i)))
                      (loop (+ i 1) current-product))])))))