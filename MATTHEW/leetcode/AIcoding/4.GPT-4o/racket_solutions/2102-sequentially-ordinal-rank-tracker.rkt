#lang racket

(struct RankTracker (values) #:transparent)

(define (make-rank-tracker)
  (RankTracker (list)))

(define (track rt n)
  (define vals (RankTracker-values rt))
  (define new-vals (sort (cons n vals) <))
  (RankTracker new-vals))

(define (get-rank rt n)
  (define vals (RankTracker-values rt))
  (define rank (length (filter (lambda (x) (< x n)) vals)))
  (add1 rank))

(define (get-rank-tracker)
  (define rt (make-rank-tracker))
  (lambda (op . args)
    (cond
      [(equal? op 'track) (set! rt (track rt (car args))) '()]
      [(equal? op 'getRank) (get-rank rt (car args))]
      [else (error "Invalid operation")])))

(define tracker (get-rank-tracker))