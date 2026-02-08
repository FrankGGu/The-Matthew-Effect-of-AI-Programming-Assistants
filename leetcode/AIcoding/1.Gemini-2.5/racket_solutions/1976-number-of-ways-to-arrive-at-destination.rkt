#lang racket

(define MOD 1000000007)
(define INF +inf.0)

(define (make-min-heap)
  (let ([heap-data (make-vector 100 #f)] ; Initial capacity, will resize
        [heap-size 0])

    ;; Doubles the capacity of the heap-data vector
    (define (resize-heap!)
      (let ([new-capacity (* 2 (vector-length heap-data))])
        (let ([new-vec (make-vector new-capacity #f)])
          (for ([i (in-range heap-size)])
            (vector-set! new-vec i (vector-ref heap-data i)))
          (set! heap-data new-vec))))

    (define (parent i) (quotient (sub1 i) 2))
    (define (left-child i) (add1 (* 2 i)))
    (define (right-child i) (add1 (* 2 (add1 i))))

    ;; Swaps elements at indices i and j in the heap-data vector
    (define (swap i j)
      (let ([temp (vector-ref heap-data i)])
        (vector-set! heap-data i (vector-ref heap-data j))
        (vector-set! heap-data j temp)))

    ;; Moves element at index i up the heap to maintain heap property
    (define (heapify-up i)
      (when (> i 0)
        (let ([p (parent i)])
          (when (< (car (vector-ref heap-data i)) (car (vector-ref heap-data p)))
            (swap i p)
            (heapify-up p)))))

    ;; Moves element at index i down the heap to maintain heap property
    (define (heapify-down i)
      (let ([l (left-child i)]
            [r (right-child i)]
            [smallest i])
        (when (and (< l heap-size)
                   (< (car (vector-ref heap-data l)) (car (vector-ref heap-data smallest))))
          (set! smallest l))
        (when (and (< r heap-size)
                   (< (car (vector-ref heap-data r)) (car (vector-ref heap-data smallest))))
          (set! smallest r))
        (when (not (= smallest i))
          (swap i smallest)
          (heapify-down smallest))))

    ;; Inserts an item into the heap
    (define (heap-insert item)
      (when (= heap-size (vector-length heap-data))
        (resize-heap!))
      (vector-set! heap-data heap-size item)
      (set! heap-size (add1 heap-size))
      (heapify-up (sub1 heap-size)))

    ;; Extracts the minimum item from the heap
    (define (heap-extract-min)
      (when (zero? heap-size)
        (error "Heap is empty"))
      (let ([min-item (vector-ref heap-data 0)])
        (set! heap-size (sub1 heap-size))
        (when (> heap-size 0)
          (vector-set! heap-data 0 (vector-ref heap-data heap-size))
          (heapify-down 0))
        min-item))

    ;; Checks if the heap is empty
    (define (heap-empty?) (zero? heap-size))

    ;; Returns a list of functions to interact with the heap
    (list heap-insert heap-extract-min heap-empty?)))

(define (number-of-ways n roads)
  ;; Adjacency list: graph[u] = list of (v . weight)
  (define graph (make-vector n '()))
  (for-each (lambda (road)
              (define u (car road))
              (define v (cadr road))
              (define t (caddr road))
              (vector-set! graph u (cons (cons v t) (vector-ref graph u)))
              (vector-set! graph v (cons (cons u t) (vector-ref graph v))))
            roads)

  ;; dist[i] = shortest time to reach city i from city 0
  (define dist (make-vector n INF))
  (vector-set! dist 0 0)

  ;; ways[i] = number of ways to reach city i with shortest time
  (define ways (make-vector n 0))
  (vector-set! ways 0 1)

  ;; Priority queue: (cost . node)
  (define-values (heap-insert! heap-extract-min! heap-empty?) (make-min-heap))

  (heap-insert! (cons 0 0)) ; Initialize PQ with (time . city) for starting city 0

  (let loop ()
    (when (not (heap-empty?))
      (define min-entry (heap-extract-min!))
      (define current-time (car min-entry))
      (define u (cdr min-entry))

      ;; If we've already found a shorter path to u, skip this entry
      (when (> current-time (vector-ref dist u))
        (loop))

      ;; Explore neighbors of u
      (for-each (lambda (edge)
                  (define v (car edge))
                  (define travel-time (cdr edge))
                  (define new-time (+ current-time travel-time))

                  ;; If a shorter path to v is found
                  (when (< new-time (vector-ref dist v))
                    (vector-set! dist v new-time)
                    (vector-set! ways v (vector-ref ways u))
                    (heap-insert! (cons new-time v)))

                  ;; If an equally short path to v is found
                  (when (= new-time (vector-ref dist v))
                    (vector-set! ways v (modulo (+ (vector-ref ways v) (vector-ref ways u)) MOD))))
                (vector-ref graph u))
      (loop)))

  ;; Return the number of ways to reach the destination city (n-1)
  (vector-ref ways (sub1 n)))