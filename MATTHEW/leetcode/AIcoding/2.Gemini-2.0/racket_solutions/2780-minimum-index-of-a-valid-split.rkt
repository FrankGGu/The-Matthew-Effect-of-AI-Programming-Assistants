(define (minimum-index valid-splits nums)
  (let* ([n (length nums)]
         [total-count (make-hash)]
         [left-count (make-hash)]
         [right-count (make-hash)]
         [max-count-num (lambda (h)
                           (if (hash-empty? h)
                               #f
                               (let loop ([keys (hash-keys h)]
                                          [max-key #f]
                                          [max-val 0])
                                 (if (null? keys)
                                     max-key
                                     (let ([key (car keys)]
                                           [val (hash-ref h key)])
                                       (if (> val max-val)
                                           (loop (cdr keys) key val)
                                           (loop (cdr keys) max-key max-val)))))))])
         [is-valid? (lambda (h count)
                       (let ([num (max-count-num h)])
                         (and num (>= (hash-ref h num) (* 2 count)))))]
         [update-count (lambda (h num)
                          (hash-update h num add1 0))])

    (for ([num nums])
      (update-count total-count num))

    (let loop ([i 0])
      (cond
        [(= i (- n 1)) -1]
        [else
         (update-count left-count (list-ref nums i))
         (hash-update total-count (list-ref nums i) sub1)
         (when (= (hash-ref total-count (list-ref nums i)) 0)
           (hash-remove! total-count (list-ref nums i)))
         (if (and (is-valid? left-count (+ i 1))
                  (is-valid? total-count (- n i 1)))
             i
             (loop (+ i 1)))]))))