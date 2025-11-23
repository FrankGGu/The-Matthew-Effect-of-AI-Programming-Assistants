(define (get-kth lo hi k)
  (define power-values (make-hash))

  (define (get-power-value n)
    (cond
      ((= n 1) 0)
      ((hash-has-key? power-values n) (hash-ref power-values n))
      (else
       (let* ((next-n (if (even? n) (/ n 2) (+ (* 3 n) 1)))
              (power (add1 (get-power-value next-n))))
         (hash-set! power-values n power)
         power))))

  (define numbers (build-list (- (+ hi 1) lo) (lambda (i) (+ lo i))))

  (define sorted-numbers
    (sort numbers
          (lambda (a b)
            (let ((pa (get-power-value a))
                  (pb (get-power-value b)))
              (or (< pa pb)
                  (and (= pa pb) (< a b)))))))

  (list-ref sorted-numbers (- k 1)))