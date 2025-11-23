(define (minimum-operations s)
  (define n (string-length s))
  (define cnt (make-hash))
  (for-each (lambda (c) (hash-set! cnt c (+ 1 (hash-ref cnt c 0)))) (string->list s))
  (define target (hash-map cnt (lambda (k v) (floor (/ v 2))))
  (define (get-k k)
    (let loop ((i 0) (j (- n 1)) (left 0) (right 0) (total 0))
      (cond
        [(>= i j) total]
        [(and (<= left (hash-ref target (string-ref s i) 0)) (<= right (hash-ref target (string-ref s j) 0)))
         (loop (+ i 1) (- j 1) (+ left 1) (+ right 1) (+ total 2))]
        [(<= left (hash-ref target (string-ref s i) 0))
         (loop (+ i 1) j (+ left 1) right (+ total 1))]
        [(<= right (hash-ref target (string-ref s j) 0))
         (loop i (- j 1) left (+ right 1) (+ total 1))]
        [else total])))
  (get-k 0))