(define (max-num-substrings s)
  (define n (string-length s))
  (define (find-ranges)
    (define first-occurrence (make-vector 26 #f))
    (define last-occurrence (make-vector 26 #f))
    (for ([i (in-range n)])
      (define char-index (- (char->integer (string-ref s i)) (char->integer #\a)))
      (unless (vector-ref first-occurrence char-index)
        (vector-set! first-occurrence char-index i))
      (vector-set! last-occurrence char-index i))
    (define ranges '())
    (for ([i (in-range n)])
      (define char-index (- (char->integer (string-ref s i)) (char->integer #\a)))
      (define left i)
      (define right (vector-ref last-occurrence char-index))
      (define j left)
      (define valid #t)
      (while (and valid (< j right))
        (define char-index-j (- (char->integer (string-ref s j)) (char->integer #\a)))
        (define first-j (vector-ref first-occurrence char-index-j))
        (define last-j (vector-ref last-occurrence char-index-j))
        (cond
          [(< first-j left) (set! valid #f)]
          [(> last-j right) (set! right last-j)])
        (set! j (+ j 1)))
      (when valid
        (set! ranges (cons (list left right) ranges))))
    ranges)

  (define ranges (find-ranges))
  (define valid-ranges (filter (lambda (range) range) ranges))

  (define (sort-by-right ranges)
    (sort ranges (lambda (a b) (< (cadr a) (cadr b)))))

  (define sorted-ranges (sort-by-right valid-ranges))

  (define (select-non-overlapping ranges last-right result)
    (cond
      [(null? ranges) result]
      [else
       (define current-range (car ranges))
       (define current-left (car current-range))
       (define current-right (cadr current-range))
       (if (>= current-left last-right)
           (select-non-overlapping (cdr ranges) (+ current-right 1) (cons (substring s current-left (+ current-right 1)) result))
           (select-non-overlapping (cdr ranges) last-right result))]))

  (reverse (select-non-overlapping sorted-ranges 0 '())))