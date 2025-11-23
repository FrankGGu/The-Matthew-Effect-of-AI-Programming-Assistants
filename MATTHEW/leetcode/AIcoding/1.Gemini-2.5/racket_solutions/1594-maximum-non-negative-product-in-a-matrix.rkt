(define (max-non-negative-product matrix-list)
  (define m (length matrix-list))
  (define n (length (car matrix-list))) ; Assuming matrix is non-empty and rectangular
  (define MOD 1000000007)

  ;; Convert matrix-list to vector-of-vectors for efficient access
  (define matrix (make-vector m))
  (for ([i (in-range m)])
    (vector-set! matrix i (list->vector (list-ref matrix-list i))))

  (define dp-min (make-vector m))
  (define dp-max (make-vector m))

  (for ([i (in-range m)])
    (vector-set! dp-min i (make-vector n))
    (vector-set! dp-max i (make-vector n)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (define val (vector-ref (vector-ref matrix i) j))

      (cond
        [(and (= i 0) (= j 0))
         (vector-set! (vector-ref dp-min 0) 0 val)
         (vector-set! (vector-ref dp-max 0) 0 val)]
        [else
         (define current-min-candidates '())
         (define current-max-candidates '())

         (when (> i 0)
           (define prev-min-up (vector-ref (vector-ref dp-min (- i 1)) j))
           (define prev-max-up (vector-ref (vector-ref dp-max (- i 1)) j))
           (if (>= val 0)
               (begin
                 (set! current-min-candidates (cons (* prev-min-up val) current-min-candidates))
                 (set! current-max-candidates (cons (* prev-max-up val) current-max-candidates)))
               (begin
                 (set! current-min-candidates (cons (* prev-max-up val) current-min-candidates))
                 (set! current-max-candidates (cons (* prev-min-up val) current-max-candidates)))))

         (when (> j 0)
           (define prev-min-left (vector-ref (vector-ref dp-min i) (- j 1)))
           (define prev-max-left (vector-ref (vector-ref dp-max i) (- j 1)))
           (if (>= val 0)
               (begin
                 (set! current-min-candidates (cons (* prev-min-left val) current-min-candidates))
                 (set! current-max-candidates (cons (* prev-max-left val) current-max-candidates)))
               (begin
                 (set! current-min-candidates (cons (* prev-max-left val) current-min-candidates))
                 (set! current-max-candidates (cons (* prev-min-left val) current-max-candidates)))))

         (vector-set! (vector-ref dp-min i) j (apply min current-min-candidates))
         (vector-set! (vector-ref dp-max i) j (apply max current-max-candidates))])))

  (define final-max (vector-ref (vector-ref dp-max (- m 1)) (- n 1)))

  (if (< final-max 0)
      -1
      (modulo final-max MOD)))