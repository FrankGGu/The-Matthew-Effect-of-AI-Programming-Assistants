(define (number-of-subarrays nums)
  (let loop ([i 0] [stack '()] [res 0])
    (if (>= i (length nums))
        res
        (let* ([num (list-ref nums i)]
               [new-stack (let drop ([s stack])
                            (if (null? s)
                                '()
                                (let ([top (car s)])
                                  (if (> (car top) num)
                                      (cons top (drop (cdr s)))
                                      (drop (cdr s)))))]
               [count (if (null? new-stack)
                          0
                          (let ([top (car new-stack)])
                            (if (= (car top) num)
                                (cdr top)
                                0)))]
               [new-count (+ count 1)]
               [new-stack (cons (cons num new-count) new-stack)])
          (loop (+ i 1) new-stack (+ res new-count))))))