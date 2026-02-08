#lang racket

(struct fmbq (front-half back-half))

(define (list-last l)
  (car (reverse l)))

(define (list-butlast l)
  (reverse (cdr (reverse l))))

(define (rebalance-after-push-front q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (if (> (length f) (length b))
        (fmbq (list-butlast f) (cons (list-last f) b))
        q)))

(define (rebalance-after-push-back q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (if (> (length b) (+ (length f) 1))
        (fmbq (cons (car b) f) (cdr b))
        q)))

(define (rebalance-after-pop q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (if (> (length f) (length b))
        (fmbq (list-butlast f) (cons (list-last f) b))
        q)))

(define (FrontMiddleBackQueue)
  (fmbq '() '()))

(define (pushFront q val)
  (rebalance-after-push-front (fmbq (cons val (fmbq-front-half q)) (fmbq-back-half q))))

(define (pushMiddle q val)
  (rebalance-after-push-back (fmbq (fmbq-front-half q) (cons val (fmbq-back-half q)))))

(define (pushBack q val)
  (rebalance-after-push-back (fmbq (fmbq-front-half q) (append (fmbq-back-half q) (list val)))))

(define (popFront q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) (list -1 q))
      ((null? f)
       (list (car b) (rebalance-after-pop (fmbq '() (cdr b)))))
      (else
       (list (car f) (rebalance-after-pop (fmbq (cdr f) b)))))))

(define (popMiddle q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) (list -1 q))
      (else
       (list (car b) (rebalance-after-pop (fmbq f (cdr b))))))))

(define (popBack q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) (list -1 q))
      ((and (null? b) (not (null? f)))
       (list (car f) (rebalance-after-pop (fmbq (cdr f) '()))))
      (else
       (list (list-last b) (rebalance-after-pop (fmbq f (list-butlast b))))))))

(define (front q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) -1)
      ((null? f) (car b))
      (else (car f)))))

(define (middle q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) -1)
      (else (car b)))))

(define (back q)
  (let ((f (fmbq-front-half q))
        (b (fmbq-back-half q)))
    (cond
      ((and (null? f) (null? b)) -1)
      ((null? b) (car f))
      (else (list-last b)))))