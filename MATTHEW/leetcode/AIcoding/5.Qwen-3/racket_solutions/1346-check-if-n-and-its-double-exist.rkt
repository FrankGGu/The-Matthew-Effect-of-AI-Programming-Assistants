#lang racket

(define/contract (check-if-n-and-its-double-exist arr)
  (-> (listof exact-integer?) boolean?)
  (let ([seen (set)])
    (for/or ([num arr])
      (let ([double (* num 2)])
        (or (set-member? seen double)
            (and (not (= num 0)) (set-member? seen (/ num 2)))
            (begin (set-add! seen num) #f))))) #f)