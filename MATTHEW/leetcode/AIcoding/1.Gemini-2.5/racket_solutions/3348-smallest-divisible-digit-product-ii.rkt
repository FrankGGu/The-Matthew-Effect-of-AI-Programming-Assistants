#lang racket

(require racket/queue)
(require racket/set)

(define (smallest-divisible-digit-product-ii n)
  (call/cc
   (lambda (return)
     (define q (make-queue))
     (define visited (set))

     (for ([d (in-range 1 10)])
       (define rem (modulo d n))
       (when (= rem 0)
         (return d))
       (unless (set-member? visited rem)
         (set! visited (set-add visited rem))
         (enqueue! q (list rem d))))

     (let bfs-loop ()
       (define current-state (dequeue! q))
       (define current-rem (first current-state))
       (define current-num (second current-state))

       (for ([d (in-range 0 10)])
         (define new-num (+ (* current-num 10) d))
         (define new-rem (modulo new-num n))

         (when (= new-rem 0)
           (return new-num))

         (unless (set-member? visited new-rem)
           (set! visited (set-add visited new-rem))
           (enqueue! q (list new-rem new-num))))
       (bfs-loop)))))