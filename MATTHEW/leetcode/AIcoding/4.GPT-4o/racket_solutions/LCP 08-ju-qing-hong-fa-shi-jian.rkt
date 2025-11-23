(define (triggerTime events)
  (define (count-triggers time)
    (length (filter (lambda (event) (<= (car event) time (cadr event))) events)))
  (define (binary-search lo hi)
    (if (= lo hi)
        lo
        (let* ((mid (quotient (+ lo hi) 2))
               (count (count-triggers mid)))
          (if (>= count 2)
              (binary-search lo mid)
              (binary-search (add1 mid) hi)))))
  (binary-search 0 1000000000))

(triggerTime '((1 2) (2 3) (4 5)))