(define (minimum-difference nums)
  (define n (length nums))
  (define half-n (quotient n 2))
  (define sum (apply + nums))

  (define (generate-sums arr k)
    (cond
      [(zero? k) (list 0)]
      [(empty? arr) '()]
      [else
       (append
        (map (lambda (x) (+ x (car arr))) (generate-sums (cdr arr) (- k 1)))
        (generate-sums (cdr arr) k))]))

  (define first-half-sums
    (for/hash ([k (in-range (+ 1 half-n))])
      (values k (sort (remove-duplicates (generate-sums (take nums half-n) k)) <))))

  (define second-half-sums
    (for/hash ([k (in-range (+ 1 (- n half-n)))])
      (values k (sort (remove-duplicates (generate-sums (drop nums half-n) k)) <))))

  (define (find-closest target arr)
    (define (binary-search left right)
      (cond
        [(>= left right) (list (list-ref arr left) (list-ref arr (sub1 right)))]
        [else
         (define mid (quotient (+ left right) 2))
         (cond
           [(< (list-ref arr mid) target) (binary-search (add1 mid) right)]
           [else (binary-search left mid)])]))
    (cond
      [(empty? arr) +inf.0]
      [(<= (length arr) 1) (list-ref arr 0)]
      [else
       (define closest-pair (binary-search 0 (length arr)))
       (let ([lower (car closest-pair)]
             [upper (cadr closest-pair)])
         (cond
           [(<= (abs (- lower target)) (abs (- upper target))) lower]
           [else upper]))]))

  (let loop ([k (in-range (+ 1 half-n))]
             [min-diff +inf.0])
    (if (= k (+ 1 half-n))
        min-diff
        (let* ([first-sums (hash-ref first-half-sums k)]
               [target (/ sum 2)]
               [remaining-k (- n half-n k)]
               [second-sums (hash-ref second-half-sums remaining-k)]
               [closest-sum (find-closest (- target (car first-sums)) second-sums)])
          (loop (add1 k) (min min-diff (abs (- sum (* 2 (+ (car first-sums) closest-sum)))))))))
)