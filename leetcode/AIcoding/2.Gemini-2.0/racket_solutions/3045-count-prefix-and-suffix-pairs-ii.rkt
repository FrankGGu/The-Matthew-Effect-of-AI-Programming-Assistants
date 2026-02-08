(define (count-prefix-suffix-pairs words)
  (define n (length words))
  (define (is-prefix-suffix? i j)
    (and
     (string=? (substring (list-ref words j) 0 (min (string-length (list-ref words i)) (string-length (list-ref words j)))) (list-ref words i))
     (string=? (substring (list-ref words j) (- (string-length (list-ref words j)) (min (string-length (list-ref words i)) (string-length (list-ref words j)))) (string-length (list-ref words j))) (list-ref words i))))

  (define (helper i count)
    (cond
      [(>= i n) count]
      [else
       (helper (+ i 1) (+ count (length (filter (lambda (j) (and (> j i) (is-prefix-suffix? i j))) (range 0 n)))))]))

  (helper 0 0))