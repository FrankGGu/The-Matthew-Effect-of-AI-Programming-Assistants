(define (smallest-string-swaps s pairs)
  (define n (string-length s))

  ;; DSU structure
  (define dsu (make-vector n))
  (define ranks (make-vector n 0))

  ;; Initialize DSU
  (for ([i (in-range n)])
    (vector-set! dsu i i))

  ;; Find operation with path compression
  (define (find i)
    (cond
      [(= (vector-ref dsu i) i) i]
      [else
       (let ([root (find (vector-ref dsu i))])
         (vector-set! dsu i root)
         root)]))

  ;; Union operation by rank
  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (let ([rank-i (vector-ref ranks root-i)]
              [rank-j (vector-ref ranks root-j)])
          (cond
            [(> rank-i rank-j)
             (vector-set! dsu root-j root-i)]
            [(< rank-i rank-j)
             (vector-set! dsu root-i root-j)]
            [else
             (vector-set! dsu root-j root-i)
             (vector-set! ranks root-i (+ rank-i 1))])))))

  ;; Apply all unions
  (for ([pair pairs])
    (union (car pair) (cdr pair)))

  ;; Group characters and original indices by their component root
  ;; hash: root -> (list (cons char index))
  (define component-data (make-hash))

  (for ([i (in-range n)])
    (let* ([root (find i)]
           [current-char (char-ref s i)])
      (hash-set! component-data root
                 (cons (cons current-char i)
                       (hash-ref component-data root '())))))

  ;; Prepare result string as a mutable character vector
  (define result-chars (make-vector n #\space))

  ;; For each component, sort characters and indices, then place them
  (for ([(root char-index-pairs) (in-hash component-data)])
    (let* ([chars (map car char-index-pairs)]
           [indices (map cdr char-index-pairs)]
           [sorted-chars (sort chars char<?)]
           [sorted-indices (sort indices <)])
      (for ([j (in-range (length sorted-chars))])
        (vector-set! result-chars (list-ref sorted-indices j) (list-ref sorted-chars j)))))

  ;; Convert the character vector back to a string
  (list->string (vector->list result-chars)))