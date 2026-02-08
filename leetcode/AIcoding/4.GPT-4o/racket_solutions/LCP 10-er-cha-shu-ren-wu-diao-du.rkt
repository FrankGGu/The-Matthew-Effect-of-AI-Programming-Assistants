(define (min-interval intervals queries)
  (define sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b)))))
  (define sorted-queries (sort (map-indexed (lambda (i v) (list v i)) queries) (lambda (a b) (< (car a) (car b)))))
  (define result (make-vector (length queries) -1))
  (define active-intervals (make-queue))
  (define j 0)

  (for ([q sorted-queries])
    (let* ([query-value (car q)]
           [query-index (cadr q)])
      (while (and (< j (length sorted-intervals))
                  (<= (car (list-ref sorted-intervals j)) query-value))
        (let ([start (car (list-ref sorted-intervals j))]
              [end (cadr (list-ref sorted-intervals j))])
          (enqueue active-intervals (list (- end start +1) end)))
          (set! j (+ j 1))))
      (while (and (not (empty? active-intervals))
                  (<= (cadr (front active-intervals)) query-value))
        (dequeue active-intervals))
      (if (empty? active-intervals)
          (vector-set! result query-index 0)
          (vector-set! result query-index (car (front active-intervals))))))

  (vector->list result))