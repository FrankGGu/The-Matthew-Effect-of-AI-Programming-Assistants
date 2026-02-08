(define (three-sum-multiplicity arr target)
  (define MOD 1000000007)
  (define n (vector-length arr))
  (define sorted-arr (vector-sort < arr))

  (define (outer-loop i current-total-ans)
    (if (>= i (- n 2))
        current-total-ans
        (let ((current-i-val (vector-ref sorted-arr i)))
          (define (inner-loop left right inner-total-ans)
            (cond
              ((>= left right) inner-total-ans)
              (else
               (let ((sum (+ current-i-val (vector-ref sorted-arr left) (vector-ref sorted-arr right))))
                 (cond
                   ((< sum target)
                    (inner-loop (+ left 1) right inner-total-ans))
                   ((> sum target)
                    (inner-loop left (- right 1) inner-total-ans))
                   (else ; sum == target
                    (let ((left-val (vector-ref sorted-arr left))
                          (right-val (vector-ref sorted-arr right)))
                      (cond
                        ((= left-val right-val)
                         (let* ((count (- right left -1))
                                (combinations (quotient (* count (- count 1)) 2)))
                           (inner-loop (+ right 1) right (modulo (+ inner-total-ans combinations) MOD))))
                        (else
                         (let* ((l-ptr-end (let loop ((ptr left))
                                             (if (and (< ptr right) (= (vector-ref sorted-arr ptr) left-val))
                                                 (loop (+ ptr 1))
                                                 ptr)))
                                (l-count (- l-ptr-end left))
                                (r-ptr-start (let loop ((ptr right))
                                               (if (and (> ptr l-ptr-end) (= (vector-ref sorted-arr ptr) right-val))
                                                   (loop (- ptr 1))
                                                   ptr)))
                                (r-count (- right r-ptr-start)))
                           (inner-loop l-ptr-end r-ptr-start (modulo (+ inner-total-ans (* l-count r-count)) MOD)))))))))))
          (outer-loop (+ i 1) (inner-loop (+ i 1) (- n 1) current-total-ans)))))
  (outer-loop 0 0))