(define (searchRange nums target)
  (define (find-left nums target)
    (define (binary-search-left low high)
      (if (>= low high)
          low
          (define mid (/ (+ low high) 2))
          (if (< (list-ref nums mid) target)
              (binary-search-left (+ mid 1) high)
              (binary-search-left low mid))))
    (binary-search-left 0 (length nums)))

  (define (find-right nums target)
    (define (binary-search-right low high)
      (if (>= low high)
          high
          (define mid (/ (+ low high) 2))
          (if (<= (list-ref nums mid) target)
              (binary-search-right (+ mid 1) high)
              (binary-search-right low mid))))
    (binary-search-right 0 (length nums)))

  (define left (find-left nums target))
  (define right (find-right nums target))
  (if (or (>= left (length nums)) (not (= (list-ref nums left) target)))
      '(-1 -1)
      (list left (- right 1))))

(searchRange)