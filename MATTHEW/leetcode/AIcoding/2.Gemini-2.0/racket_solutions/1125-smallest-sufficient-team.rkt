(define (smallest-sufficient-team req_skills people)
  (let* ([n (length req_skills)]
         [m (length people)]
         [skill-map (make-hash)]
         [dp (make-vector (expt 2 n) '())])

    (for ([i (in-range n)])
      (hash-set! skill-map (list-ref req_skills i) i))

    (vector-set! dp 0 '())

    (for ([i (in-range m)])
      (let* ([person (list-ref people i)]
             [mask (for/fold ([m 0]) ([skill (in-list person)])
                     (if (hash-has-key? skill-map skill)
                         (bitwise-ior m (expt 2 (hash-ref skill-map skill)))
                         m))])

        (for ([j (in-range (expt 2 n))])
          (when (not (null? (vector-ref dp j)))
            (let* ([new-mask (bitwise-ior j mask)]
                   [new-team (append (vector-ref dp j) (list i))])
              (when (or (null? (vector-ref dp new-mask))
                        (< (length new-team) (length (vector-ref dp new-mask))))
                (vector-set! dp new-mask new-team)))))))

    (vector-ref dp (- (expt 2 n) 1))))