#lang racket

(define +infinity+ (expt 10 10))

(struct min-heap (data size) #:mutable #:transparent)

(define (make-empty-min-heap)
  (min-heap (make-vector 10000 '()) 0))

(define (heap-empty? h)
  (= (min-heap-size h) 0))

(define (heap-parent i) (quotient (- i 1) 2))
(define (heap-left-child i) (+ (* 2 i) 1))
(define (heap-right-child i) (+ (* 2 i) 2))

(define (heap-swap! h i j)
  (define data (min-heap-data h))
  (define temp (vector-ref data i))
  (vector-set! data i (vector-ref data j))
  (vector-set! data j temp))

(define (heap-bubble-up! h idx)
  (let loop ([i idx])
    (define p (heap-parent i))
    (when (and (> i 0) (< (car (vector-ref (min-heap-data h) i)) (car (vector-ref (min-heap-data h) p))))
      (heap-swap! h i p)
      (loop p))))

(define (heap-bubble-down! h idx)
  (let loop ([i idx])
    (define data (min-heap-data h))
    (define current-size (min-heap-size h))
    (define l (heap-left-child i))
    (define r (heap-right-child i))
    (define smallest i)

    (when (and (< l current-size) (< (car (vector-ref data l)) (car (vector-ref data smallest))))
      (set! smallest l))
    (when (and (< r current-size) (< (car (vector-ref data r)) (car (vector-ref data smallest))))
      (set! smallest r))

    (when (not (= smallest i))
      (heap-swap! h i smallest)
      (loop smallest))))

(define (heap-push! h item)
  (define data (min-heap-data h))
  (define current-size (min-heap-size h))

  (when (= current-size (vector-length data))
    (define new-data (make-vector (* 2 current-size) '()))
    (for ([i (in-range current-size)])
      (vector-set! new-data i (vector-ref data i)))
    (set-min-heap-data! h new-data))

  (vector-set! (min-heap-data h) current-size item)
  (set-min-heap-size! h (+ current-size 1))
  (heap-bubble-up! h current-size))

(define (heap-pop! h)
  (if (heap-empty? h)
      #f
      (let* ([data (min-heap-data h)]
             [min-item (vector-ref data 0)]
             [current-size (min-heap-size h)])

        (set-min-heap-size! h (- current-size 1))

        (when (> current-size 1)
          (vector-set! data 0 (vector-ref data (- current-size 1)))
          (heap-bubble-down! h 0))
        min-item)))

(struct graph (adj num-nodes) #:transparent)

(define (graph-init n edges)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define cost (caddr edge))
              (vector-set! adj u (cons (list v cost) (vector-ref adj u))))
            edges)
  (graph adj n))

(define (graph-add-edge g edge)
  (define u (car edge))
  (define v (cadr edge))
  (define cost (caddr edge))
  (vector-set! (graph-adj g) u (cons (list v cost) (vector-ref (graph-adj g) u))))

(define (graph-shortest-path g node1 node2)
  (define n (graph-num-nodes g))
  (define adj (graph-adj g))

  (define dist (make-vector n +infinity+))
  (vector-set! dist node1 0)

  (define pq (make-empty-min-heap))
  (heap-push! pq (list 0 node1))

  (let loop ()
    (when (not (heap-empty? pq))
      (define current-item (heap-pop! pq))
      (define current-cost (car current-item))
      (define u (cadr current-item))

      (when (> current-cost (vector-ref dist u))
        (loop))

      (when (= u node2)
        (void))

      (for-each (lambda (neighbor-info)
                  (define v (car neighbor-info))
                  (define weight (cadr neighbor-info))

                  (when (< (+ (vector-ref dist u) weight) (vector-ref dist v))
                    (vector-set! dist v (+ (vector-ref dist u) weight))
                    (heap-push! pq (list (vector-ref dist v) v))))
                (vector-ref adj u))
      (loop)))

  (if (= (vector-ref dist node2) +infinity+)
      -1
      (vector-ref dist node2)))