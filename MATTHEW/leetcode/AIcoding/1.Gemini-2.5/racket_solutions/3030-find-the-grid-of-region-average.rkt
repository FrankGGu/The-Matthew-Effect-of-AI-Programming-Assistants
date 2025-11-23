(define (find-grid-of-region-average grid threshold)
  (define m (length grid))
  (define n (length (car grid)))

  (define result-sum (build-list m (lambda (r) (build-list n (lambda (c) 0)))))
  (define result-count (build-list m (lambda (r) (build-list n (lambda (c) 0)))))

  (define (get-grid-val r c)
    (list-ref (list-ref grid r) c))

  (define (is-region-valid? r-start c-start)
    (and
     (for/and ([i (in-range r-start (+ r-start 3))]
               [j (in-range c-start (+ c-start 2))])
       (<= (abs (- (get-grid-val i j) (get-grid-val i (+ j 1)))) threshold))
     (for/and ([i (in-range r-start (+ r-start 2))]
               [j (in-range c-start (+ c-start 3))])
       (<= (abs (- (get-grid-val i j) (get-grid-val (+ i 1) j))) threshold))))

  (for* ([r-start (in-range 0 (- m 2))]
         [c-start (in-range 0 (- n 2))])
    (define region-sum 0)

    (for* ([i (in-range r-start (+ r-start 3))]
           [j (in-range c-start (+ c-start 3))])
      (set! region-sum (+ region-sum (get-grid-val i j))))

    (when (is-region-valid? r-start c-start)
      (define region-average (floor (/ region-sum 9)))
      (for* ([i (in-range r-start (+ r-start 3))]
             [j (in-range c-start (+ c-start 3))])
        (list-set! (list-ref result-sum i) j
                   (+ (list-ref (list-ref result-sum i) j) region-average))
        (list-set! (list-ref result-count i) j
                   (+ (list-ref (list-ref result-count i) j) 1)))))

  (build-list m
    (lambda (r)
      (build-list n
        (lambda (c)
          (define count (list-ref (list-ref result-count r) c))
          (if (> count 0)
              (floor (/ (list-ref (list-ref result-sum r) c) count))
              (get-grid-val r c))))))
)