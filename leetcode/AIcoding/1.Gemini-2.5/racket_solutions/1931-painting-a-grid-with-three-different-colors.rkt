(define (paint-grid m n)
  (define MOD 1000000007)

  (define (generate-valid-rows m)
    (define (helper current-row k)
      (if (= k m)
        (list current-row)
        (apply append (map (lambda (color)
                             (if (or (empty? current-row) (not (= color (last current-row))))
                               (helper (append current-row (list color)) (+ k 1))
                               '()))
                           '(0 1 2)))))
    (helper '() 0))

  (define valid-rows (generate-valid-rows m))
  (define num-configs (length valid-rows))

  (define valid-rows-vec (list->vector valid-rows))

  (define (compatible? row1 row2)
    (andmap (lambda (c1 c2) (not (= c1 c2))) row1 row2))

  (define compatibility-matrix (make-vector num-configs))
  (for ([i (in-range num-configs)])
    (vector-set! compatibility-matrix i (make-vector num-configs #f)))

  (for ([i (in-range num-configs)])
    (for ([j (in-range num-configs)])
      (when (compatible? (vector-ref valid-rows-vec i) (vector-ref valid-rows-vec j))
        (vector-set! (vector-ref compatibility-matrix i) j #t))))

  (define prev-dp (make-vector num-configs 1))

  (for ([i (in-range 1 n)])
    (define current-dp (make-vector num-configs 0))
    (for ([j (in-range num-configs)])
      (for ([k (in-range num-configs)])
        (when (vector-ref (vector-ref compatibility-matrix j) k)
          (vector-set! current-dp j
                       (modulo (+ (vector-ref current-dp j) (vector-ref prev-dp k))
                               MOD)))))
    (set! prev-dp current-dp))

  (define total-ways 0)
  (for ([val (in-vector prev-dp)])
    (set! total-ways (modulo (+ total-ways val) MOD)))

  total-ways)