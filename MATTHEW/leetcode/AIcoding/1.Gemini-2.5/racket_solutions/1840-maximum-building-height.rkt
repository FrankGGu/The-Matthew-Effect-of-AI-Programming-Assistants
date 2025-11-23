(require racket/hash)
(require racket/list)
(require racket/vector)

(define (max-building-height n restrictions)
  ;; 1. Process restrictions:
  ;;    - Use a hash map to handle potential duplicate IDs and ensure Building 1 has height 0.
  ;;    - Building 1 must have a height of 0, overriding any other restriction for ID 1.
  (define restriction-map (make-hash))
  (for-each (lambda (r)
              (hash-set! restriction-map (car r) (cdr r)))
            restrictions)
  (hash-set! restriction-map 1 0) ; Building 1 must have height 0

  ;; Convert map to a list of pairs and sort by ID.
  (define processed-restrictions-raw
    (sort (hash-map restriction-map cons)
          (lambda (a b) (< (car a) (car b)))))

  ;; 2. Add a dummy restriction for building `n` if it's not already restricted.
  ;;    This ensures that the segment from the last actual restriction to building `n`
  ;;    is properly considered in the two passes and the tent formula.
  ;;    A very large height is used for building `n` so it doesn't artificially constrain
  ;;    previous buildings, allowing them to reach their maximum possible heights.
  (define k (length processed-restrictions-raw))
  (define last-id-raw (car (list-ref processed-restrictions-raw (- k 1))))

  (define final-restrictions processed-restrictions-raw)
  (when (< last-id-raw n)
    (set! final-restrictions
          (append final-restrictions (list (cons n (+ n 1000000000)))))) ; Use a sufficiently large height
  (set! k (length final-restrictions)) ; Update k after potential append

  ;; `constrained-h-vec` will store the adjusted heights for the restricted buildings
  ;; after applying the slope constraints from both left and right.
  (define constrained-h-vec (make-vector k))

  ;; 3. Left-to-right pass:
  ;;    For each restricted building `i`, calculate its maximum possible height
  ;;    considering the height of the previous restricted building `i-1` and the slope constraint.
  ;;    `height[id_i] <= min(original_height[id_i], height[id_{i-1}] + (id_i - id_{i-1}))`
  (vector-set! constrained-h-vec 0 (list-ref final-restrictions 0)) ; Initialize with (1,0)

  (for ([i (in-range 1 k)])
    (define prev-id (car (vector-ref constrained-h-vec (- i 1))))
    (define prev-h (cdr (vector-ref constrained-h-vec (- i 1))))
    (define current-id (car (list-ref final-restrictions i)))
    (define current-h-orig (cdr (list-ref final-restrictions i)))
    (define constrained-h (min current-h-orig (+ prev-h (- current-id prev-id))))
    (vector-set! constrained-h-vec i (cons current-id constrained-h)))

  ;; 4. Right-to-left pass:
  ;;    Further constrain the heights calculated in the left pass, now considering
  ;;    the height of the next restricted building `i+1` and the slope constraint.
  ;;    `height[id_i] <= min(height[id_i]_from_left_pass, height[id_{i+1}] + (id_{i+1} - id_i))`
  (for ([i (in-range (- k 2) -1 -1)]) ; Iterate from k-2 down to 0
    (define next-id (car (vector-ref constrained-h-vec (+ i 1))))
    (define next-h (cdr (vector-ref constrained-h-vec (+ i 1))))
    (define current-id (car (vector-ref constrained-h-vec i)))
    (define current-h-from-left (cdr (vector-ref constrained-h-vec i)))
    (define constrained-h-final (min current-h-from-left (+ next-h (- next-id current-id))))
    (vector-set! constrained-h-vec i (cons current-id constrained-h-final)))

  ;; 5. Calculate the maximum possible height.
  ;;    This involves checking the heights of the restricted buildings themselves,
  ;;    and also the maximum possible heights of buildings *between* any two adjacent restricted buildings.
  (define max-overall-height 0)
  ;; First, update with the heights of the restricted buildings.
  (for ([i (in-range k)])
    (set! max-overall-height (max max-overall-height (cdr (vector-ref constrained-h-vec i)))))

  ;; Then, consider buildings between adjacent restricted points.
  ;; For a segment between (id_i, h_i) and (id_{i+1}, h_{i+1}), the maximum height
  ;; is achieved at a "peak" in the middle, forming a tent shape.
  ;; The peak height is `floor((h_i + h_{i+1} + D) / 2)`, where `D = id_{i+1} - id_i`.
  (for ([i (in-range (- k 1))]) ; Iterate from 0 to k-2
    (define id-i (car (vector-ref constrained-h-vec i)))
    (define h-i (cdr (vector-ref constrained-h-vec i)))
    (define id-i+1 (car (vector-ref constrained-h-vec (+ i 1))))
    (define h-i+1 (cdr (vector-ref constrained-h-vec (+ i 1))))
    (define D (- id-i+1 id-i))

    (define segment-max-h (floor (/ (+ h-i h-i+1 D) 2)))
    (set! max-overall-height (max max-overall-height segment-max-h)))

  max-overall-height)