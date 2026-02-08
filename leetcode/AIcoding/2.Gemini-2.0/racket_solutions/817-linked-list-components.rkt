(define (num-components head nums)
  (let loop ([curr head] [set (set nums)] [count 0])
    (cond
      [(null? curr) count]
      [(set-member? (list-ref curr 0) set)
       (let loop2 ([curr2 (list-ref curr 1)] [found #t])
         (cond
           [(null? curr2) (+ count 1)]
           [(set-member? (list-ref curr2 0) set) (loop2 (list-ref curr2 1) found)]
           [else (+ count 1)]))]
      [else (loop (list-ref curr 1) set count)])))