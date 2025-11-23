(define (rotate-function nums)
  (let* ([n (length nums)]
         [sum (foldl + 0 nums)]
         [f0 (foldl (lambda (i acc) (+ (* i (list-ref nums (- n i 1))) acc)) 0 (range n))]
         (let loop ([i 1] [max-f f0] [fi f0])
           (if (= i n)
               max-f
               (let ([next-fi (+ fi sum (- (* n (list-ref nums (- n i)))))])
                 (loop (+ i 1) (max max-f next-fi) next-fi))))))