(define/contract (furthest-distance-from-origin moves)
  (-> string? exact-integer?)
  (let* ([l-count (count (lambda (c) (char=? c #\L)) (string->list moves))]
         [r-count (count (lambda (c) (char=? c #\R)) (string->list moves))]
         [m-count (- (string-length moves) l-count r-count)])
    (+ (abs (- l-count r-count)) m-count)))