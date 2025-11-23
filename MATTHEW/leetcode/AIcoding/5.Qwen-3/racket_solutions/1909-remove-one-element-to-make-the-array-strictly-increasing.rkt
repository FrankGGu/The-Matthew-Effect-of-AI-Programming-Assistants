#lang racket

(define (can-convert lst)
  (define (check lst skip?)
    (let loop ([i 0] [prev -inf.0])
      (cond [(>= i (length lst)) #t]
            [(and skip? (= i (length lst))) #t]
            [(or (and skip? (= i (sub1 (length lst)))) (< (list-ref lst i) prev)) #f]
            [(and (not skip?) (< (list-ref lst i) prev)) (loop i prev)]
            [else (loop (add1 i) (list-ref lst i))])))
  (if (check lst #f) #t
      (let ([len (length lst)])
        (or (check (append (take lst 0) (drop lst 1)) #t)
            (check (append (take lst (sub1 len)) (drop lst len)) #t)))))

(define/contract (can-convert lst)
  (-> (listof exact-integer?) boolean?)
  (can-convert lst))