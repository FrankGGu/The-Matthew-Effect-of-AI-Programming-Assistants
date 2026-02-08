(require racket/set)

(define (max-count-integers-to-choose banned n max-sum)
  (let ([banned-set (list->set banned)])
    (let loop ([i 1]
               [count 0]
               [current-sum 0])
      (cond
        [(> i n) count]
        [(set-member? banned-set i)
         (loop (add1 i) count current-sum)]
        [(<= (+ current-sum i) max-sum)
         (loop (add1 i) (add1 count) (+ current-sum i))]
        [else
         count]))))