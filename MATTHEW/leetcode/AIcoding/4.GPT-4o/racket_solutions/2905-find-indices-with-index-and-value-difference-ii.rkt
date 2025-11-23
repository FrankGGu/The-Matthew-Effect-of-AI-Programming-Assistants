(define (find-indices nums diff)
  (define (helper i n)
    (if (>= i (length nums))
        '()
        (let* ((current (list-ref nums i))
               (idx (find (lambda (x) (= (list-ref nums x) (+ current diff)))
                           (range (add1 i) (length nums)))))
          (if idx
              (cons (list i idx) (helper (add1 i) n))
              (helper (add1 i) n)))))
  (helper 0 (length nums)))

(define (find-indices-with-difference nums diff)
  (find-indices nums diff))