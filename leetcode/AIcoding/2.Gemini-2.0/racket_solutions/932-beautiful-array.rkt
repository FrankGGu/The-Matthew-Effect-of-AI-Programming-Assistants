(define (beautiful-array n)
  (letrec ([recur (lambda (arr)
                     (if (= (length arr) n)
                         arr
                         (let ([odds (filter odd? arr)]
                               [evens (filter even? arr)])
                           (recur (append (map (lambda (x) (* 2 x) ) odds) (map (lambda (x) (+ 1 (* 2 x))) evens)))))]
           [initial-arr '(1)])
    (recur initial-arr)))