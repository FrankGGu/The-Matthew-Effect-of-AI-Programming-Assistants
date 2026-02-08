(define (min-deletion-size strs)
  (define (can_sort? col)
    (let loop ((i 1) (prev (string-ref (list-ref strs 0) col)))
      (if (>= i (length strs))
          #t
          (let ((current (string-ref (list-ref strs i) col)))
            (if (string<=? (string prev) (string current))
                (loop (+ i 1) current)
                #f)))))

  (define (count_deletions start)
    (if (>= start (length (car strs)))
        0
        (let loop ((i start) (dels 0))
          (if (can_sort? i)
              (count_deletions (+ i 1))
              (loop (+ i 1) (+ dels 1))))))

  (count_deletions 0))

(define (min-deletion-size strs)
  (min-deletion-size strs))