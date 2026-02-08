#lang racket

(define (maximum-sum-queries nums1 nums2 queries)
  (define n (vector-length nums1))
  (define m (vector-length queries))

  (define points
    (for/list ([i (in-range n)])
      (list (vector-ref nums1 i) (vector-ref nums2 i))))

  (define queries-with-idx
    (for/list ([j (in-range m)])
      (list (vector-ref (vector-ref queries j) 0)
            (vector-ref (vector-ref queries j) 1)
            j)))

  (define all-y-coords-raw
    (append (map second points)
            (map second queries-with-idx)))
  (define all-y-coords
    (sort (remove-duplicates all-y-coords-raw) <))

  (define y-to-idx (make-hash))
  (for ([i (in-range (length all-y-coords))]
        [y (in-list all-y-coords)])
    (hash-set! y-to-idx y i))

  (define num-unique-y (length all-y-coords))

  (define sorted-points (list->vector (sort points (lambda (p1 p2) (> (first p1) (first p2))))))
  (define sorted-queries (sort queries-with-idx (lambda (q1 q2) (> (first q1) (first q2)))))

  (define seg-tree (make-vector (* 4 num-unique-y) -1))

  (define (update-seg-tree node-idx start end target-idx val)
    (when (<= start end)
      (cond
        ((= start end)
         (vector-set! seg-tree node-idx (max (vector-ref seg-tree node-idx) val)))
        (else
         (define mid (quotient (+ start end) 2))
         (if (<= target-idx mid)
             (update-seg-tree (* 2 node-idx) start mid target-idx val)
             (update-seg-tree (+ (* 2 node-idx) 1) (+ mid 1) end target-idx val))
         (vector-set! seg-tree node-idx
                      (max (vector-ref seg-tree (* 2 node-idx))
                           (vector-ref seg-tree (+ (* 2 node-idx) 1))))))))

  (define (query-seg-tree node-idx start end query-start query-end)
    (cond
      ((or (> start query-end) (< end query-start))
       -1)
      ((and (>= start query-start) (<= end query-end))
       (vector-ref seg-tree node-idx))
      (else
       (define mid (quotient (+ start end) 2))
       (max (query-seg-tree (* 2 node-idx) start mid query-start query-end)
            (query-seg-tree (+ (* 2 node-idx) 1) (+ mid 1) end query-start query-end)))))

  (define results (make-vector m -1))
  (define point-ptr 0)

  (for ([query sorted-queries])
    (define xj (first query))
    (define yj (second query))
    (define original-idx (third query))

    (while (and (< point-ptr n)
                (>= (first (vector-ref sorted-points point-ptr)) xj))
      (define current-num1 (first (vector-ref sorted-points point-ptr)))
      (define current-num2 (second (vector-ref sorted-points point-ptr)))
      (define y-idx (hash-ref y-to-idx current-num2))
      (update-seg-tree 1 0 (- num-unique-y 1) y-idx (+ current-num1 current-num2))
      (set! point-ptr (+ point-ptr 1)))

    (define query-y-idx (hash-ref y-to-idx yj))
    (define max-sum (query-seg-tree 1 0 (- num-unique-y 1) query-y-idx (- num-unique-y 1)))
    (vector-set! results original-idx max-sum))

  (vector->list results))