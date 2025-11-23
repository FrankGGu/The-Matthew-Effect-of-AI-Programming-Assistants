(define (minimum-convert-cost source target original changed costs)
  (let* ([n (length original)]
         [m (string-length source)]
         [infinity (expt 10 18)]
         [dist (make-hash)])
    (for ([i n])
      (let ([u (list-ref original i)]
            [v (list-ref changed i)]
            [cost (list-ref costs i)])
        (hash-update! dist (cons u v) (lambda (old) (min old cost)) infinity))
    (let ([keys (hash-keys dist)])
      (for ([k keys])
        (let ([u (car k)]
              [v (cdr k)])
          (hash-update! dist (cons u u) (lambda (old) (min old 0)) infinity)
          (hash-update! dist (cons v v) (lambda (old) (min old 0)) infinity)))
    (let ([nodes (remove-duplicates (append original changed))])
      (for ([k nodes])
        (for ([i nodes])
          (for ([j nodes])
            (let ([ik (hash-ref dist (cons i k) infinity)]
                  [kj (hash-ref dist (cons k j) infinity)]
                  [ij (hash-ref dist (cons i j) infinity)])
              (when (> ij (+ ik kj))
                (hash-set! dist (cons i j) (+ ik kj))))))))
    (let ([dp (make-vector (add1 m) infinity)])
      (vector-set! dp 0 0)
      (for ([i (in-range m)])
        (when (vector-ref dp i)
          (for ([j (in-range i m)])
            (let ([sub-s (substring source i (add1 j))]
                  [sub-t (substring target i (add1 j))])
              (if (string=? sub-s sub-t)
                  (vector-set! dp (add1 j) (min (vector-ref dp (add1 j)) (vector-ref dp i)))
                  (let ([cost (hash-ref dist (cons sub-s sub-t) infinity)])
                    (when (< cost infinity)
                      (vector-set! dp (add1 j) (min (vector-ref dp (add1 j)) (+ (vector-ref dp i) cost)))))))))
      (if (= (vector-ref dp m) infinity) -1 (vector-ref dp m)))))