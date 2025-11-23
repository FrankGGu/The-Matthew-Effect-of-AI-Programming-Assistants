#lang racket

(define (make-exam-room n)
  (let ([seats (set)]
        [occupied (set)])
    (define (distance s)
      (if (set-empty? occupied)
          (- n 1)
          (let ([left (set-first (set-subtract (set-intersect (set s) occupied) (set s)))]
                [right (set-first (set-intersect (set-add (set s) n) occupied))])
            (cond [(not left) (- n s)]
                  [(not right) s]
                  [else (min (- s left) (- right s))]))))
    (define (next-seat)
      (if (set-empty? occupied)
          0
          (argmax (lambda (s) (distance s)) (range n))))
    (define (add-occupant s)
      (set! occupied (set-add occupied s))
      (set! seats (set-add seats s)))
    (define (remove-occupant s)
      (set! occupied (set-remove occupied s))
      (set! seats (set-remove seats s)))
    (lambda (msg . args)
      (case msg
        [(occupy) (add-occupant (car args))]
        [(leave) (remove-occupant (car args))]
        [(next) (next-seat)]))))

(define (solve n queries)
  (define room (make-exam-room n))
  (for-each (lambda (q)
              (cond [(equal? (car q) 'occupy) ((room 'occupy) (cadr q))]
                    [(equal? (car q) 'leave) ((room 'leave) (cadr q))]))
            queries)
  (map (lambda (q) ((room 'next))) queries))