(define (find-rotate-steps ring key)
  (define ring-len (string-length ring))
  (define key-len (string-length key))
  (define pos (make-hash))
  (for ([i (in-range ring-len)])
    (let ([c (string-ref ring i)])
      (hash-update! pos c (lambda (v) (cons i v)) (list i))))
  (define dp (make-vector key-len (make-vector ring-len #f)))
  (define (solve k r)
    (cond
      [(= k key-len) 0]
      [(vector-ref (vector-ref dp k) r) (vector-ref (vector-ref dp k) r)]
      [else
       (let ([c (string-ref key k)]
             [res +inf.0])
         (for ([p (in-list (hash-ref pos c '()))])
           (let ([diff (abs (- p r))]
                 [cost (+ 1 (min diff (- ring-len diff)))])
             (set! res (min res (+ cost (solve (+ k 1) p))))))
         (vector-set! (vector-ref dp k) r res)
         res)]))
  (solve 0 0))