(define/contract (max-average-pass-ratio classes extra-students)
  (-> (listof (listof exact-integer?)) exact-integer? flonum?)
  (define max-heap (make-heap (lambda (a b) (> (car a) (car b)))))
  (for ([class classes])
    (let ([pass (car class)]
          [total (cadr class)])
      (heap-add! max-heap (cons (/ (- pass) (* total (+ total 1))) pass total))))
  (for ([_ (in-range extra-students)])
    (let* ([top (heap-remove! max-heap)]
           [delta (car top)]
           [pass (cadr top)]
           [total (cddr top)])
      (heap-add! max-heap (cons (/ (- (+ pass 1)) (* (+ total 1) (+ total 2))) (+ pass 1) (+ total 1)))))
  (define total-ratio 0.0)
  (for ([class (heap->list max-heap)])
    (let ([pass (cadr class)]
          [total (cddr class)])
      (set! total-ratio (+ total-ratio (/ pass total)))))
  (/ total-ratio (length classes)))