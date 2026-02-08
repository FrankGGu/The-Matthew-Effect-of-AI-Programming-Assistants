(define/contract (paths-with-max-score board)
  (-> (listof string?) (listof exact-integer?))
  (define m (length board))
  (define n (string-length (first board)))
  (define mod 1000000007)

  (define dp (make-vector m (make-vector n '(0 0))))
  (define (get-val i j)
    (let ([c (string-ref (list-ref board i) j)])
      (cond
        [(char=? c #\X) -1]
        [(char=? c #\E) 0]
        [else (- (char->integer c) (char->integer #\0))])))

  (vector-set! (vector-ref dp (- m 1)) (- n 1) '(0 1))

  (for ([i (in-range (- m 1) -1 -1)])
    (for ([j (in-range (- n 1) -1 -1)])
      (when (and (not (and (= i (- m 1)) (= j (- n 1))))
                 (not (= (get-val i j) -1)))
        (let* ([max-sum 0]
               [count 0]
               [dirs '((1 0) (0 1) (1 1))])
          (for ([dir dirs])
            (let ([ni (+ i (first dir))]
                  [nj (+ j (second dir))])
              (when (and (< ni m) (< nj n))
                (let ([res (vector-ref (vector-ref dp ni) nj)])
                  (when (> (first res) max-sum)
                    (set! max-sum (first res))
                    (set! count (second res)))
                  (when (= (first res) max-sum)
                    (set! count (modulo (+ count (second res)) mod))))))
          (vector-set! (vector-ref dp i) j (list (+ max-sum (get-val i j)) count))))))

  (let ([res (vector-ref (vector-ref dp 0) 0)])
    (if (= (second res) 0)
        '(0 0)
        res)))