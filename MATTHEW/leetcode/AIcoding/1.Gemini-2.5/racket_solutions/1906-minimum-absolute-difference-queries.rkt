(define (min-absolute-difference-queries nums queries)
  (define MAX-VAL 100)

  (define num-len (length nums))
  (define prefix-counts
    (let loop ((i 0)
               (current-counts (make-vector (add1 MAX-VAL) 0))
               (acc (list current-counts)))
      (if (= i num-len)
          (reverse acc)
          (let* ((val (list-ref nums i))
                 (next-counts (vector-copy current-counts)))
            (vector-set! next-counts val (add1 (vector-ref next-counts val)))
            (loop (add1 i) next-counts (cons next-counts acc))))))

  (define (process-query L R)
    (define start-counts (list-ref prefix-counts L))
    (define end-counts (list-ref prefix-counts (add1 R)))

    (define present-values '())
    (for ((val (in-range MAX-VAL 0 -1)))
      (when (> (- (vector-ref end-counts val) (vector-ref start-counts val)) 0)
        (set! present-values (cons val present-values))))

    (cond
      ((<= (length present-values) 1) -1)
      (else
       (let loop ((i 0)
                  (min-diff MAX-VAL))
         (if (= i (- (length present-values) 1))
             min-diff
             (let* ((val1 (list-ref present-values i))
                    (val2 (list-ref present-values (add1 i)))
                    (diff (- val2 val1)))
               (loop (add1 i) (min min-diff diff))))))))

  (map process-query queries))