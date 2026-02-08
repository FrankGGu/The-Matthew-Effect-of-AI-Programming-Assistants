(define (describe-the-painting segments)
  (define (merge-intervals intervals)
    (if (null? intervals)
        '()
        (let loop ([sorted-intervals (sort intervals < #:key car)]
                   [merged '()])
          (cond
            [(null? sorted-intervals) (reverse merged)]
            [(null? (cdr sorted-intervals)) (reverse (cons (car sorted-intervals) merged))]
            [else
             (let ([curr (car sorted-intervals)]
                   [next (car (cdr sorted-intervals))])
               (if (<= (cadr curr) (car next))
                   (loop (cdr sorted-intervals) (cons curr merged))
                   (loop (cons (list (car curr) (max (cadr curr) (cadr next)) (caddr curr) (caddr next)) (cdr (cdr sorted-intervals))) merged)))]))))

  (define (build-intervals segments)
    (let loop ([segments segments]
               [intervals '()])
      (if (null? segments)
          (sort intervals < #:key car)
          (let ([segment (car segments)])
            (loop (cdr segments) (cons (list (car segment) (cadr segment) (caddr segment)) intervals))))
    )

  (define (build-diff-map intervals)
    (let loop ([intervals intervals]
               [diff-map (make-hash)])
      (if (null? intervals)
          diff-map
          (let ([interval (car intervals)])
            (hash-update! diff-map (car interval) (lambda (v) (+ v (caddr interval))) 0)
            (hash-update! diff-map (cadr interval) (lambda (v) (- v (caddr interval))) 0)
            (loop (cdr intervals) diff-map)))))

  (define (build-result diff-map)
    (let* ([sorted-keys (sort (hash-keys diff-map) <)]
           [result '()])
      (let loop ([keys sorted-keys]
                 [current-val 0]
                 [result '()])
        (cond
          [(null? (cdr keys)) (reverse result)]
          [else
           (let* ([start (car keys)]
                  [end (car (cdr keys))]
                  [current-val (+ current-val (hash-ref diff-map start))])
             (if (= current-val 0)
                 (loop (cdr keys) current-val result)
                 (loop (cdr keys) current-val (cons (list start end current-val) result))))]))))

  (define intervals (build-intervals segments))
  (define diff-map (build-diff-map intervals))
  (build-result diff-map)
)