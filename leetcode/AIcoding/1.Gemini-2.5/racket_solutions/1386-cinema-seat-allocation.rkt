#lang racket
(require racket/set)

(define (cinema-seat-allocation n reserved-seats)
  (define row-reservations (make-hash))

  (for-each (lambda (seat)
              (define row (car seat))
              (define col (cadr seat))
              (hash-update! row-reservations row
                            (lambda (cols) (set-add cols col))
                            (set)))
            reserved-seats)

  (define total-families 0)

  (hash-for-each
   row-reservations
   (lambda (row reserved-cols)
     (define can-seat-left
       (and (not (set-member? reserved-cols 2))
            (not (set-member? reserved-cols 3))
            (not (set-member? reserved-cols 4))
            (not (set-member? reserved-cols 5))))

     (define can-seat-right
       (and (not (set-member? reserved-cols 6))
            (not (set-member? reserved-cols 7))
            (not (set-member? reserved-cols 8))
            (not (set-member? reserved-cols 9))))

     (define can-seat-middle
       (and (not (set-member? reserved-cols 4))
            (not (set-member? reserved-cols 5))
            (not (set-member? reserved-cols 6))
            (not (set-member? reserved-cols 7))))

     (cond
       ((and can-seat-left can-seat-right)
        (set! total-families (+ total-families 2)))
       ((or can-seat-left can-seat-right can-seat-middle)
        (set! total-families (+ total-families 1)))
       (else
        #f))))

  (define num-rows-with-reservations (hash-count row-reservations))
  (set! total-families (+ total-families (* (- n num-rows-with-reservations) 2)))

  total-families)