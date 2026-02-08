(define (maxCandies boxes)
  (define (dfs box-idx visited)
    (if (or (null? box-idx) (member box-idx visited))
        0
        (let* ((new-visited (cons box-idx visited))
               (candies (vector-ref boxes box-idx))
               (next-boxes (vector-ref boxes box-idx)))
          (+ candies (apply + (map (lambda (b) (dfs b new-visited)) next-boxes))))))
  (dfs 0 '()))

(define (maxCandiesWrapper boxes)
  (maxCandies (vector->list boxes)))

(maxCandiesWrapper (vector (vector 1 (vector 1 2)) (vector 2 (vector 0)) (vector 3 (vector 0)) (vector 0 (vector))))