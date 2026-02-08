(define (smallest-range-k-lists lists)
  (define pq (mutable-heap (λ (a b) (< (car a) (car b)))))
  (define k (length lists))
  (define max-val (apply max (map car lists)))
  (define range-start 0)
  (define range-end (+ max-val 1))

  (for ([i (in-range k)])
    (mutable-heap-add! pq (list (car (list-ref lists i)) i 0))
    )

  (define (update-range start end)
    (if (< (- end start) (- range-end range-start))
        (begin
          (set! range-start start)
          (set! range-end end))))

  (let loop ()
    (define min-element (mutable-heap-remove-min! pq))
    (define min-val (car min-element))
    (define list-index (cadr min-element))
    (define element-index (caddr min-element))

    (update-range min-val max-val)

    (if (= (+ 1 element-index) (length (list-ref lists list-index)))
        (values range-start range-end)
        (let ([next-element (list-ref (list-ref lists list-index) (+ 1 element-index))])
          (mutable-heap-add! pq (list next-element list-index (+ 1 element-index)))
          (set! max-val (max max-val next-element))
          (loop)))))

(define (solve lists)
  (define-values (start end) (smallest-range-k-lists lists))
  (list start end))