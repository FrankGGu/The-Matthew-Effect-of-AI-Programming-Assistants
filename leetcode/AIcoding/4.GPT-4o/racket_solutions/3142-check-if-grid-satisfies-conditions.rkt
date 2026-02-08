(define (check-grid grid)
  (define (check-row row)
    (let loop ((count 0) (i 0))
      (cond
        [(= i (length row)) #t]
        [(= (list-ref row i) 1) (loop (+ count 1) (+ i 1))]
        [(> count 2) #f]
        [else (loop count (+ i 1))])))

  (define (check-column col)
    (let loop ((count 0) (i 0))
      (cond
        [(= i (length grid)) #t]
        [(= (list-ref (list-ref grid i) col) 1) (loop (+ count 1) (+ i 1))]
        [(> count 2) #f]
        [else (loop count (+ i 1))])))

  (for/fold ([valid #t]) ([i 0 (sub1 (length grid))])
    (if (and valid (check-row (list-ref grid i)))
        (for/fold ([valid #t]) ([j 0 (sub1 (length grid))])
          (if (and valid (check-column j)) valid #f)
          valid)
        #f)))