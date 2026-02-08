(define (group-the-people group-sizes)
  (define groups-by-size (make-hash))
  (define result '())

  (for ([size (in-list group-sizes)]
        [person-id (in-naturals)])
    (define current-data (hash-ref groups-by-size size (list 0 '())))
    (define current-count (car current-data))
    (define current-group-rev (cadr current-data))

    (define new-group-rev (cons person-id current-group-rev))
    (define new-count (+ current-count 1))

    (if (= new-count size)
        (begin
          (set! result (cons (reverse new-group-rev) result))
          (hash-set! groups-by-size size (list 0 '())))
        (hash-set! groups-by-size size (list new-count new-group-rev))))

  (reverse result))