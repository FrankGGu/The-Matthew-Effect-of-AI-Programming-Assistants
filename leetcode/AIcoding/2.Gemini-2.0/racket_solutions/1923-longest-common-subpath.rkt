(define (longest-common-subpath n paths)
  (define (check-length len)
    (define (get-hashes path)
      (define p 31)
      (define m (expt 10 9) + 9)
      (define p-pow (make-vector (add1 (length path)) 1))
      (for ([i (range 1 (add1 (length path)))])
        (vector-set! p-pow i (modulo (* (vector-ref p-pow (sub1 i)) p) m)))
      (define hashes (make-vector (add1 (length path)) 0))
      (for ([i (range 1 (add1 (length path)))])
        (vector-set! hashes i (modulo (+ (* (vector-ref hashes (sub1 i)) p) (list-ref path (sub1 i))) m)))
      hashes)

    (define (get-hash hashes l r)
      (define p 31)
      (define m (expt 10 9) + 9)
      (modulo (- (vector-ref hashes (add1 r)) (* (vector-ref hashes l) (vector-ref p-pow (add1 (- r l))))) m))

    (define hashes-list (map get-hashes paths))
    (define first-path-hashes (list-ref hashes-list 0))
    (define possible-hashes (make-hash))
    (for ([i (range (- (length (list-ref paths 0)) len) 0 -1)])
      (hash-set! possible-hashes (get-hash first-path-hashes i (+ i len -1)) #t))

    (for ([path-index (range 1 (length paths))])
      (define path-hashes (list-ref hashes-list path-index))
      (define current-path-hashes (make-hash))
      (for ([i (range (- (length (list-ref paths path-index)) len) 0 -1)])
        (define current-hash (get-hash path-hashes i (+ i len -1)))
        (when (hash-ref possible-hashes current-hash #f)
          (hash-set! current-path-hashes current-hash #t)))
      (set! possible-hashes current-path-hashes))

    (not (hash-empty? possible-hashes)))

  (define (binary-search low high)
    (cond
      [(> low high) low]
      [else
       (let* ([mid (floor (/ (+ low high) 2))]
              [can-have-len (check-length mid)])
         (if can-have-len
             (binary-search (add1 mid) high)
             (binary-search low (sub1 mid))))]))

  (binary-search 0 (apply min (map length paths))))