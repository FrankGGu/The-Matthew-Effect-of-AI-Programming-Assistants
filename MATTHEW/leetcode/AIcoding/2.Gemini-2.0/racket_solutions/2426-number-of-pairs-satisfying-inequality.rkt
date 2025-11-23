(define (count-pairs nums1 nums2 diff)
  (define n (vector-length nums1))
  (define diffs (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! diffs i (- (vector-ref nums1 i) (vector-ref nums2 i))))

  (define (merge-sort arr)
    (define (merge left right)
      (define result (make-vector (+ (vector-length left) (vector-length right)) 0))
      (define i 0)
      (define j 0)
      (define k 0)
      (while (and (< i (vector-length left)) (< j (vector-length right)))
        (if (<= (vector-ref left i) (vector-ref right j))
            (begin
              (vector-set! result k (vector-ref left i))
              (set! i (+ i 1)))
            (begin
              (vector-set! result k (vector-ref right j))
              (set! j (+ j 1))))
        (set! k (+ k 1)))

      (while (< i (vector-length left))
        (vector-set! result k (vector-ref left i))
        (set! i (+ i 1))
        (set! k (+ k 1)))

      (while (< j (vector-length right))
        (vector-set! result k (vector-ref right j))
        (set! j (+ j 1))
        (set! k (+ k 1)))

      result)

    (define (sort-helper arr)
      (if (<= (vector-length arr) 1)
          arr
          (let* ([mid (floor (/ (vector-length arr) 2))]
                 [left (vector-copy arr 0 mid)]
                 [right (vector-copy arr mid (vector-length arr))]
                 [sorted-left (sort-helper left)]
                 [sorted-right (sort-helper right)])
            (merge sorted-left sorted-right))))

    (sort-helper arr))

  (define sorted-diffs (merge-sort diffs))

  (define count 0)
  (for ([i (in-range n)])
    (let loop ([j 0])
      (cond
        [(>= j n) #f]
        [(<= (vector-ref diffs i) (+ (vector-ref sorted-diffs j) diff)) (set! count (+ count (- n j))) #f]
        [else (loop (+ j 1))])))

  count)