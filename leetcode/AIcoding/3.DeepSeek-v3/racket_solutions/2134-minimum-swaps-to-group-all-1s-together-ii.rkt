(define (min-swaps nums)
  (let* ([n (length nums)]
         [count-ones (count (lambda (x) (= x 1)) nums)]
         [window-size count-ones]
         [max-ones-in-window 
          (let loop ([left 0] [right 0] [current-ones 0] [max-ones 0])
            (if (>= right n)
                max-ones
                (let* ([new-right (modulo right n)]
                       [new-current-ones (+ current-ones (if (= (list-ref nums new-right) 1) 1 0))]
                       [new-max-ones (max max-ones new-current-ones)])
                  (if (>= (- right left) (sub1 window-size))
                      (loop (add1 left) (add1 right) 
                            (- new-current-ones (if (= (list-ref nums (modulo left n)) 1) 1 0)) 
                            new-max-ones)
                      (loop left (add1 right) new-current-ones new-max-ones))))])
    (- window-size max-ones-in-window)))