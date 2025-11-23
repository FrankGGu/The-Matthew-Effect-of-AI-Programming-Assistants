(define (max-sum-obtained-of-any-permutation nums requests)
  (define n (length nums))
  (define MOD 1000000007)

  (define diff-counts (make-vector n 0))

  (for-each (lambda (req)
              (define start (car req))
              (define end (cadr req))
              (vector-set! diff-counts start (+ (vector-ref diff-counts start) 1))
              (when (< (+ end 1) n)
                (vector-set! diff-counts (+ end 1) (- (vector-ref diff-counts (+ end 1)) 1))))
            requests)

  (define frequencies (make-vector n 0))
  (define current-count 0)
  (for ([i (in-range n)])
    (set! current-count (+ current-count (vector-ref diff-counts i)))
    (vector-set! frequencies i current-count))

  (define nums-list (sort nums >))
  (define freq-list (sort (vector->list frequencies) >))

  (define total-sum 0)
  (for ([num nums-list]
        [freq freq-list])
    (set! total-sum
          (modulo (+ total-sum (modulo (* num freq) MOD))
                  MOD)))

  total-sum)