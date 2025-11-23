#lang racket

(struct circular-deque (capacity data front rear count) #:mutable)

(define (positive-modulo n m)
  (let ((rem (remainder n m)))
    (if (negative? rem) (+ rem m) rem)))

(define (my-circular-deque-init k)
  (circular-deque k (make-vector k 0) -1 -1 0))

(define (my-circular-deque-insert-front deque value)
  (if (= (circular-deque-count deque) (circular-deque-capacity deque))
      #f
      (begin
        (if (= (circular-deque-count deque) 0)
            (begin
              (set-circular-deque-front! deque 0)
              (set-circular-deque-rear! deque 0))
            (set-circular-deque-front! deque
                                       (positive-modulo (- (circular-deque-front deque) 1)
                                                        (circular-deque-capacity deque))))
        (vector-set! (circular-deque-data deque) (circular-deque-front deque) value)
        (set-circular-deque-count! deque (+ (circular-deque-count deque) 1))
        #t)))

(define (my-circular-deque-insert-last deque value)
  (if (= (circular-deque-count deque) (circular-deque-capacity deque))
      #f
      (begin
        (if (= (circular-deque-count deque) 0)
            (begin
              (set-circular-deque-front! deque 0)
              (set-circular-deque-rear! deque 0))
            (set-circular-deque-rear! deque
                                    (positive-modulo (+ (circular-deque-rear deque) 1)
                                                     (circular-deque-capacity deque))))
        (vector-set! (circular-deque-data deque) (circular-deque-rear deque) value)
        (set-circular-deque-count! deque (+ (circular-deque-count deque) 1))
        #t)))

(define (my-circular-deque-delete-front deque)
  (if (= (circular-deque-count deque) 0)
      #f
      (begin
        (set-circular-deque-count! deque (- (circular-deque-count deque) 1))
        (if (= (circular-deque-count deque) 0)
            (begin
              (set-circular-deque-front! deque -1)
              (set-circular-deque-rear! deque -1))
            (set-circular-deque-front! deque
                                       (positive-modulo (+ (circular-deque-front deque) 1)
                                                        (circular-deque-capacity deque))))
        #t)))

(define (my-circular-deque-delete-last deque)
  (if (= (circular-deque-count deque) 0)
      #f
      (begin
        (set-circular-deque-count! deque (- (circular-deque-count deque) 1))
        (if (= (circular-deque-count deque) 0)
            (begin
              (set-circular-deque-front! deque -1)
              (set-circular-deque-rear! deque -1))
            (set-circular-deque-rear! deque
                                      (positive-modulo (- (circular-deque-rear deque) 1)
                                                       (circular-deque-capacity deque))))
        #t)))

(define (my-circular-deque-get-front deque)
  (if (= (circular-deque-count deque) 0)
      -1
      (vector-ref (circular-deque-data deque) (circular-deque-front deque))))

(define (my-circular-deque-get-rear deque)
  (if (= (circular-deque-count deque) 0)
      -1
      (vector-ref (circular-deque-data deque) (circular-deque-rear deque))))

(define (my-circular-deque-is-empty deque)
  (= (circular-deque-count deque) 0))

(define (my-circular-deque-is-full deque)
  (= (circular-deque-count deque) (circular-deque-capacity deque)))