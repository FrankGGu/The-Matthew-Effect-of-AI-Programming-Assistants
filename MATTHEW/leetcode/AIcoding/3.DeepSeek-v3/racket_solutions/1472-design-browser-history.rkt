#lang racket

(struct browser-history (history current) #:mutable)

(define (make-browser-history homepage)
  (browser-history (list homepage) 0))

(define (browser-history-visit bh url)
  (let ([history (browser-history-history bh)]
        [current (browser-history-current bh)])
    (set-browser-history-history! bh (append (take history (add1 current)) (list url)))
    (set-browser-history-current! bh (add1 (browser-history-current bh)))))

(define (browser-history-back bh steps)
  (let ([current (browser-history-current bh)])
    (set-browser-history-current! bh (max 0 (- current steps)))
    (list-ref (browser-history-history bh) (browser-history-current bh))))

(define (browser-history-forward bh steps)
  (let* ([history (browser-history-history bh)]
         [current (browser-history-current bh)]
         [max-steps (- (sub1 (length history)) current)])
    (set-browser-history-current! bh (min (sub1 (length history)) (+ current steps)))
    (list-ref history (browser-history-current bh))))

(define (browser-history-visit! bh url)
  (browser-history-visit bh url)
  (void))

(define (browser-history-back! bh steps)
  (browser-history-back bh steps))

(define (browser-history-forward! bh steps)
  (browser-history-forward bh steps))