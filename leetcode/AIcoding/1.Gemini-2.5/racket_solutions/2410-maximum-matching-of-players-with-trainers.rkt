#lang racket

(define/contract (maximum-matching-of-players-with-trainers players trainers)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let ([sorted-players (sort players <)]
        [sorted-trainers (sort trainers <)])
    (let loop ([p-list sorted-players]
               [t-list sorted-trainers]
               [matches 0])
      (cond
        [(or (empty? p-list) (empty? t-list)) matches]
        [(<= (car p-list) (car t-list))
         (loop (cdr p-list) (cdr t-list) (+ matches 1))]
        [else
         (loop p-list (cdr t-list) matches)]))))