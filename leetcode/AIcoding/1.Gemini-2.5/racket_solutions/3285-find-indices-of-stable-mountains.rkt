#lang racket/base

(struct deque (front back) #:mutable)

(define (deque-empty? dq)
  (and (null? (deque-front dq)) (null? (deque-back dq))))

(define (deque-push-back! dq val)
  (set-deque-back! dq (cons val (deque-back dq))))

(define (deque-pop-front! dq)
  (cond
    ((not (null? (deque-front dq)))
     (let ([val (car (deque-front dq))])
       (set-deque-front! dq (cdr (deque-front dq)))
       val))
    ((not (null? (deque-back dq)))
     (set-deque-front! dq (reverse (deque-back dq)))
     (set-deque-back! dq '())
     (deque-pop-front! dq))
    (else
     (error "deque-pop-front!: deque is empty"))))

(define (deque-peek-front dq)
  (cond
    ((not (null? (deque-front dq)))
     (car (deque-front dq)))
    ((not (null? (deque-back dq)))
     (set-deque-front! dq (reverse (deque-back dq)))
     (set-deque-back! dq '())
     (deque-peek-front dq))
    (else
     (error "deque-peek-front: deque is empty"))))

(define (deque-pop-back! dq)
  (cond
    ((not (null? (deque-back dq)))
     (let ([val (car (deque-back dq))])
       (set-deque-back! dq (cdr (deque-back dq)))
       val))
    ((not (null? (deque-front dq)))
     (set-deque-back! dq (reverse (deque-front dq)))
     (set-deque-front! dq '())
     (deque-pop-back! dq))
    (else
     (error "deque-pop-back!: deque is empty"))))

(define (deque-peek-back dq)
  (cond
    ((not (null? (deque-back dq)))
     (car (deque-back dq)))
    ((not (null? (deque-front dq)))
     (set-deque-back! dq (reverse (deque-front dq)))
     (set-deque-front! dq '())
     (deque-peek-back dq))
    (else
     (error "deque-peek-back: deque is empty"))))

(define (make-empty-deque)
  (deque '() '()))

(define (find-stable-mountains mountains k)
  (define n (vector-length mountains))
  (when (< n 3)
    (error "Array length must be at least 3")) ; LeetCode problem constraints usually ensure this or specify empty list.

  (define left-cond (make-vector n #f))
  (define dq (make-empty-deque))

  (for ([j (in-range n)])
    (let loop-pop-front ()
      (when (and (not (deque-empty? dq))
                 (< (deque-peek-front dq) (- j k)))
        (deque-pop-front! dq)
        (loop-pop-front)))

    (when (and (not (deque-empty? dq))
               (< (vector-ref mountains (deque-peek-front dq)) (vector-ref mountains j)))
      (vector-set! left-cond j #t))

    (let loop-pop-back ()
      (when (and (not (deque-empty? dq))
                 (>= (vector-ref mountains (deque-peek-back dq)) (vector-ref mountains j)))
        (deque-pop-back! dq)
        (loop-pop-back)))
    (deque-push-back! dq j))

  (define right-cond (make-vector n #f))
  (set-deque-front! dq '())
  (set-deque-back! dq '())

  (for ([j (in-range (- n 1) -1 -1)])
    (let loop-pop-front ()
      (when (and (not (deque-empty? dq))
                 (> (deque-peek-front dq) (+ j k)))
        (deque-pop-front! dq)
        (loop-pop-front)))

    (when (and (not (deque-empty? dq))
               (< (vector-ref mountains (deque-peek-front dq)) (vector-ref mountains j)))
      (vector-set! right-cond j #t))

    (let loop-pop-back ()
      (when (and (not (deque-empty? dq))
                 (>= (vector-ref mountains (deque-peek-back dq)) (vector-ref mountains j)))
        (deque-pop-back! dq)
        (loop-pop-back)))
    (deque-push-back! dq j))

  (define result '())
  (for ([j (in-range n)])
    (when (and (vector-ref left-cond j) (vector-ref right-cond j))
      (set! result (cons j result))))

  (reverse result))