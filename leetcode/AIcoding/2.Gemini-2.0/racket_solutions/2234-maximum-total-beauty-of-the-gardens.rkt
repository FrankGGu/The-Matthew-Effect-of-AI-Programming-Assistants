(define (maximum-beauty gardens new-flowers target full partial)
  (define n (length gardens))
  (define sorted-gardens (sort gardens <))

  (define (check-full gardens target)
    (foldl (lambda (garden acc)
             (+ acc (min garden target)))
           0
           gardens))

  (define (calculate-beauty full-count partial-val)
    (+ (* full-count full) (* partial-val partial)))

  (define (find-max-partial-beauty remaining-flowers gardens)
    (define (binary-search left right)
      (if (> left right)
          right
          (let ((mid (floor (+ left right) 2)))
            (define total-needed (foldl (lambda (garden acc)
                                           (if (< garden mid)
                                               (+ acc (- mid garden))
                                               acc))
                                         0
                                         gardens))
            (if (<= total-needed remaining-flowers)
                (binary-search (+ mid 1) right)
                (binary-search left (- mid 1))))))
    (binary-search 0 (+ (list-ref gardens (- (length gardens) 1)) (quotient remaining-flowers (length gardens)))))

  (let loop ((i (- n 1)) (remaining-flowers new-flowers) (current-max 0))
    (cond
      ((< i -1) current-max)
      ((< (list-ref sorted-gardens i) target)
       (let ((needed-flowers (- target (list-ref sorted-gardens i))))
         (if (>= remaining-flowers needed-flowers)
             (loop (- i 1) (- remaining-flowers needed-flowers) current-max)
             current-max)))
      (else
       (let* ((full-count (+ (- n i) -1))
              (remaining-gardens (take sorted-gardens (+ i 1)))
              (partial-val (find-max-partial-beauty remaining-flowers remaining-gardens))
              (beauty (calculate-beauty full-count partial-val)))
         (loop (- i 1) remaining-flowers (max current-max beauty)))))))