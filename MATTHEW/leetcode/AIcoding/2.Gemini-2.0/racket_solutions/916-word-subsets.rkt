(define (word-subsets a b)
  (define (char-counts s)
    (let ((counts (make-vector 26 0)))
      (for ([c (in-string s)])
        (vector-set! counts (- (char->integer c) (char->integer #\a))
                     (add1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
      counts))

  (define (max-counts b)
    (let ((max-counts (make-vector 26 0)))
      (for ([word (in-list b)])
        (let ((counts (char-counts word)))
          (for ([i (in-range 26)])
            (vector-set! max-counts i (max (vector-ref max-counts i) (vector-ref counts i))))))
      max-counts))

  (define (is-subset? word max-counts)
    (let ((counts (char-counts word)))
      (let loop ([i 0])
        (cond
          [(>= i 26) #t]
          [(>= (vector-ref counts i) (vector-ref max-counts i)) (loop (add1 i))]
          [else #f]))))

  (let ((max-b-counts (max-counts b)))
    (filter (lambda (word) (is-subset? word max-b-counts)) a)))