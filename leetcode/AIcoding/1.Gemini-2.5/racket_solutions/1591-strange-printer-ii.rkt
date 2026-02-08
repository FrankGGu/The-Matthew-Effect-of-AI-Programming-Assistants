#lang racket

(require racket/queue)
(require racket/hash)

(define (is-printable targetGrid)
  (define m (vector-length targetGrid))
  (define n (vector-length (vector-ref targetGrid 0)))

  (define max-color 60)

  ;; Bounding box for each color
  ;; Initialize min-r/c to a value larger than any possible coordinate
  ;; Initialize max-r/c to a value smaller than any possible coordinate
  (define min-r (make-vector (+ max-color 1) m))
  (define max-r (make-vector (+ max-color 1) -1))
  (define min-c (make-vector (+ max-color 1) n))
  (define max-c (make-vector (+ max-color 1) -1))

  ;; Keep track of unique colors present in the grid
  (define colors-present (make-hasheq))

  ;; Step 1 & 2: Find bounding boxes and collect present colors
  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (define color (vector-ref (vector-ref targetGrid r) c))
      (hash-set! colors-present color #t)
      (vector-set! min-r color (min (vector-ref min-r color) r))
      (vector-set! max-r color (max (vector-ref max-r color) r))
      (vector-set! min-c color (min (vector-ref min-c color) c))
      (vector-set! max-c color (max (vector-ref max-c color) c)))))

  ;; Step 3: Initialize adjacency list and in-degrees
  ;; adj will be a vector where each element is a hasheq (acting as a set of neighbors)
  (define adj (make-vector (+ max-color 1) (void)))
  (for ([i (in-range (+ max-color 1))])
    (vector-set! adj i (make-hasheq)))
  (define indegree (make-vector (+ max-color 1) 0))

  ;; Step 4: Build dependency graph
  ;; For each color, iterate its bounding box. If a cell within the box has a different color C',
  ;; then the current color must be printed before C'. Add an edge (color -> C').
  (for ([color (hash-keys colors-present)])
    (define r-min (vector-ref min-r color))
    (define r-max (vector-ref max-r color))
    (define c-min (vector-ref min-c color))
    (define c-max (vector-ref max-c color))

    (for ([r (in-range r-min (+ r-max 1))])
      (for ([c (in-range c-min (+ c-max 1))])
        (define c-prime (vector-ref (vector-ref targetGrid r) c))
        (when (not (= color c-prime))
          ;; Add edge: color -> c-prime
          ;; Use hash-set! to ensure unique edges and prevent duplicate indegree increments
          (when (not (hash-has-key? (vector-ref adj color) c-prime))
            (hash-set! (vector-ref adj color) c-prime #t)
            (vector-set! indegree c-prime (+ (vector-ref indegree c-prime) 1)))))))

  ;; Step 5: Topological Sort (Kahn's algorithm)
  (define q (make-queue))
  (define num-unique-colors (hash-count colors-present))
  (define printed-count 0)

  ;; Enqueue all colors with an in-degree of 0
  (for ([color (hash-keys colors-present)])
    (when (= (vector-ref indegree color) 0)
      (enqueue! q color)))

  (while (not (queue-empty? q))
    (define u (dequeue! q))
    (set! printed-count (+ printed-count 1))

    ;; For each neighbor v of u
    (for ([v (hash-keys (vector-ref adj u))])
      (vector-set! indegree v (- (vector-ref indegree v) 1))
      (when (= (vector-ref indegree v) 0)
        (enqueue! q v))))

  ;; Step 6: Check if all unique colors were printed
  ;; If printed-count equals num-unique-colors, it means no cycles were found, and a valid
  ;; printing order exists. Otherwise, a cycle exists, and it's impossible.
  (= printed-count num-unique-colors))