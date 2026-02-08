(struct deque (vec front rear size cap) #:mutable #:transparent)

(define (make-deque k)
  (deque (make-vector k) 0 0 0 k))

(define (insert-front obj dq)
  (let ([vec (deque-vec dq)]
        [front (deque-front dq)]
        [rear (deque-rear dq)]
        [size (deque-size dq)]
        [cap (deque-cap dq)])
    (if (= size cap)
        #f
        (begin
          (set-deque-front! dq (modulo (- front 1) cap))
          (vector-set! vec (deque-front dq) obj)
          (set-deque-size! dq (+ size 1))
          #t))))

(define (insert-last obj dq)
  (let ([vec (deque-vec dq)]
        [front (deque-front dq)]
        [rear (deque-rear dq)]
        [size (deque-size dq)]
        [cap (deque-cap dq)])
    (if (= size cap)
        #f
        (begin
          (vector-set! vec rear obj)
          (set-deque-rear! dq (modulo (+ rear 1) cap))
          (set-deque-size! dq (+ size 1))
          #t))))

(define (delete-front dq)
  (let ([vec (deque-vec dq)]
        [front (deque-front dq)]
        [rear (deque-rear dq)]
        [size (deque-size dq)]
        [cap (deque-cap dq)])
    (if (= size 0)
        #f
        (begin
          (set-deque-front! dq (modulo (+ front 1) cap))
          (set-deque-size! dq (- size 1))
          #t))))

(define (delete-last dq)
  (let ([vec (deque-vec dq)]
        [front (deque-front dq)]
        [rear (deque-rear dq)]
        [size (deque-size dq)]
        [cap (deque-cap dq)])
    (if (= size 0)
        #f
        (begin
          (set-deque-rear! dq (modulo (- rear 1) cap))
          (set-deque-size! dq (- size 1))
          #t))))

(define (get-front dq)
  (if (= (deque-size dq) 0)
      -1
      (vector-ref (deque-vec dq) (deque-front dq))))

(define (get-rear dq)
  (if (= (deque-size dq) 0)
      -1
      (vector-ref (deque-vec dq) (modulo (- (deque-rear dq) 1) (deque-cap dq)))))

(define (is-empty dq)
  (= (deque-size dq) 0))

(define (is-full dq)
  (= (deque-size dq) (deque-cap dq)))