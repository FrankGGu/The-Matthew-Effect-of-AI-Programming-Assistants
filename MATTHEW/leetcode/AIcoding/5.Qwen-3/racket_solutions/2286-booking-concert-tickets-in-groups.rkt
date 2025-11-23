#lang racket

(define (bisect-right lst x)
  (define (helper low high)
    (if (>= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (> (list-ref lst mid) x)
              (helper low mid)
              (helper (+ mid 1) high)))))
  (helper 0 (length lst)))

(define (create-sorted-list lst)
  (define (iter remaining result)
    (if (null? remaining)
        result
        (let ((pos (bisect-right result (car remaining))))
          (iter (cdr remaining) (append (take result pos) (list (car remaining)) (drop result pos))))))
  (iter lst '()))

(define (bookTickets n requests)
  (define (process-requests requests tickets)
    (cond ((null? requests) tickets)
          ((= (car requests) 0) (process-requests (cdr requests) tickets))
          (else
           (let* ((pos (bisect-right tickets (car requests)))
                  (new-tickets (append (take tickets pos) (list (car requests)) (drop tickets pos))))
             (process-requests (cdr requests) new-tickets)))))
  (process-requests requests '()))