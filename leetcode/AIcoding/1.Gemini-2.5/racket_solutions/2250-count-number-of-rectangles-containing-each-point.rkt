#lang racket

(define (solve rectangles points)
  ;; --- Fenwick Tree (BIT) Implementation ---
  (struct bit (size tree) #:transparent)

  (define (make-bit n)
    (bit n (make-vector (+ n 1) 0)))

  (define (bit-update! bit-obj idx val)
    (let* ((n (bit-size bit-obj))
           (tree (bit-tree bit-obj)))
      (let loop ((i (+ idx 1))) ; BIT is 1-indexed internally, idx is 0-indexed
        (when (<= i n)
          (vector-set! tree i (+ (vector-ref tree i) val))
          (loop (+ i (bitwise-and i (- i))))))))

  (define (bit-query bit-obj idx)
    (let* ((tree (bit-tree bit-obj)))
      (let loop ((i (+ idx 1)) ; BIT is 1-indexed internally, idx is 0-indexed
                 (sum 0))
        (if (> i 0)
            (loop (bitwise-and i (- i)) (+ sum (vector-ref tree i)))
            sum))))

  ;; --- Binary Search for coordinate compression ---
  ;; Finds the index of the first element >= target in a sorted vector
  (define (bisect-left vec target)
    (let* ((low 0)
           (high (vector-length vec)))
      (let loop ((l low) (h high))
        (if (< l h)
            (let ((mid (quotient (+ l h) 2)))
              (if (>= (vector-ref vec mid) target)
                  (loop l mid)
                  (loop (+ mid 1) h)))
            l))))

  ;; --- Main Logic ---

  ;; 1. Sort rectangles by height (descending)
  (define rects-sorted
    (sort rectangles (lambda (r1 r2) (> (cadr r1) (cadr r2))))) ; (cadr r) gets height

  ;; 2. Sort points by y-coordinate (descending), keeping original index
  (define points-with-idx
    (map (lambda (p i) (list (cadr p) (car p) i)) points (range (length points))))
  (define points-sorted-with-idx
    (sort points-with-idx (lambda (p1 p2) (> (car p1) (car p2))))) ; (car p) gets y-coord

  ;; 3. Collect all unique L coordinates and create a mapping
  (define all-l-coords-list
    (sort (remove-duplicates (map car rectangles)) <)) ; (car r) gets length
  (define all-l-coords-vec (list->vector all-l-coords-list))
  (define l-to-idx (make-hash))
  (for ([l all-l-coords-list] [i (range (length all-l-coords-list))])
    (hash-set! l-to-idx l i))

  ;; 4. Initialize Fenwick tree
  (define bit-tree (make-bit (length all-l-coords-list)))

  ;; 5. Initialize results array
  (define ans (make-vector (length points) 0))

  ;; 6. Iterate through sorted points
  (define current-rect-ptr (make-box 0)) ; Mutable pointer for rectangles

  (for ([p-data points-sorted-with-idx])
    (let* ((yj (car p-data))
           (xj (cadr p-data))
           (original-idx (caddr p-data)))

      ;; Add rectangles whose height is >= current yj
      (let loop-rects ()
        (let ((r-ptr (unbox current-rect-ptr)))
          (when (and (< r-ptr (length rects-sorted))
                     (>= (cadr (list-ref rects-sorted r-ptr)) yj))
            (let* ((li (car (list-ref rects-sorted r-ptr)))
                   (l-compressed-idx (hash-ref l-to-idx li)))
              (bit-update! bit-tree l-compressed-idx 1)
              (set-box! current-rect-ptr (+ r-ptr 1))
              (loop-rects)))))

      ;; Query BIT for count of rectangles with li >= xj
      (let* ((query-l-compressed-idx (bisect-left all-l-coords-vec xj))
             (total-sum (bit-query bit-tree (sub1 (vector-length all-l-coords-vec))))
             (sum-before-query-idx (if (> query-l-compressed-idx 0)
                                       (bit-query bit-tree (sub1 query-l-compressed-idx))
                                       0))
             (count-ge-xj (- total-sum sum-before-query-idx)))
        (vector-set! ans original-idx count-ge-xj))))

  (vector->list ans))