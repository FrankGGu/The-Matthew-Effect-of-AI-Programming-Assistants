(define (count-range-sum nums lower upper)
  (define (merge-sort sums)
    (if (< (length sums) 2)
        (list sums 0)
        (let* ([mid (quotient (length sums) 2)]
               [left (take sums mid)]
               [right (drop sums mid)]
               [sorted-left (merge-sort left)]
               [sorted-right (merge-sort right)]
               [merged (merge (car sorted-left) (car sorted-right)]
               [count (foldl (lambda (x acc)
                                (let ([lower-bound (+ x lower)]
                                      [upper-bound (+ x upper)])
                                  (let-values ([(left-count right-count)
                                                 (count-in-range (car sorted-right) lower-bound upper-bound)])
                                    (+ acc left-count right-count))))
                              0 (car sorted-left))]))
          (values merged (+ count (cadr sorted-left) (cadr sorted-right))))))

  (define (count-in-range sorted-sums lower upper)
    (let ([lower-index (find-index (lambda (x) (< x lower)) sorted-sums)]
          [upper-index (find-index (lambda (x) (<= upper x)) sorted-sums)])
      (if (and lower-index upper-index)
          (- upper-index lower-index)
          0)))

  (define prefix-sums (foldl (lambda (acc x)
                                (cons (+ (if (null? acc) 0 (car acc)) x) acc))
                              '() nums))
  (define sorted-sums (sort prefix-sums <))
  (merge-sort sorted-sums))

(define (find-index pred lst)
  (let loop ([lst lst] [index 0])
    (cond
      [(null? lst) index]
      [(pred (car lst)) index]
      [else (loop (cdr lst) (+ index 1))])))

(define (merge left right)
  (cond
    [(null? left) right]
    [(null? right) left]
    [(< (car left) (car right))
     (cons (car left) (merge (cdr left) right))]
    [else
     (cons (car right) (merge left (cdr right)))]))