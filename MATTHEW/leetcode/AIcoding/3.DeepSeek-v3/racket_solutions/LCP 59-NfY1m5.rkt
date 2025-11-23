#lang racket

(define/contract (cross-river stones)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([pos 0] [last-jump 0] [steps 0] [stones (sort stones <)])
    (cond
      [(>= pos (last stones)) steps]
      [(= pos (last stones)) steps]
      [else
       (let* ([next-pos (find-next-pos pos stones)]
              [jump (- next-pos pos)])
         (if (or (<= jump (add1 last-jump)) (zero? last-jump))
             (loop next-pos jump (add1 steps) stones)
             (loop pos last-jump steps (remove next-pos stones))))])))

(define (find-next-pos pos stones)
  (let loop ([stones stones])
    (cond
      [(null? stones) pos]
      [(> (car stones) pos) (car stones)]
      [else (loop (cdr stones))])))