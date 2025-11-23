(define (kth-smallest-product A B k)
  (define (count-less-equal x)
    (foldl (lambda (b acc)
              (+ acc (if (<= (* (car A) b) x) (length A) (count (lambda (a) (<= (* a b) x)) A))))
            0 B))

  (define (binary-search left right)
    (if (= left right)
        left
        (let* ((mid (quotient (+ left right) 2))
               (count (count-less-equal mid)))
          (if (< count k)
              (binary-search (+ mid 1) right)
              (binary-search left mid)))))

  (binary-search 0 (* (last A) (last B)))
)

(kth-smallest-product (list 1 7) (list 3 4) 3)