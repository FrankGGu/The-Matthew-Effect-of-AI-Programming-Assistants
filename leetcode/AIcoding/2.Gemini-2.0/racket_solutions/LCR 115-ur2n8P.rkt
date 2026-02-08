(define (sequence-reconstruction org seqs)
  (define n (length org))
  (define adj (make-vector (add1 n) '()))
  (define indegree (make-vector (add1 n) 0))
  (define valid? #t)

  (for ([seq seqs])
    (for/fold ([prev (car seq)])
              ([curr (cdr seq)])
      (cond
        [(or (< prev 1) (> prev n) (< curr 1) (> curr n))
         (set! valid? #f)
         curr]
        [else
         (unless (member curr (vector-ref adj prev))
           (vector-set! adj prev (cons curr (vector-ref adj prev)))
           (vector-set! indegree curr (add1 (vector-ref indegree curr))))
         curr])))

  (if (not valid?)
      #f
      (begin
        (define q (list))
        (for ([i (range 1 (add1 n))])
          (when (= (vector-ref indegree i) 0)
            (set! q (append q (list i)))))

        (define reconstructed '())
        (while (not (null? q))
          (cond
            [(> (length q) 1)
             (return #f)]
            [else
             (define u (car q))
             (set! q (cdr q))
             (set! reconstructed (append reconstructed (list u)))

             (for ([v (vector-ref adj u)])
               (vector-set! indegree v (sub1 (vector-ref indegree v)))
               (when (= (vector-ref indegree v) 0)
                 (set! q (append q (list v)))))]))

        (and (= (length reconstructed) n)
             (equal? org reconstructed)))))