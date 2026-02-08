(define/contract (check-inclusion s1 s2)
  (-> string? string? boolean?)
  (define len1 (string-length s1))
  (define len2 (string-length s2))
  (when (< len2 len1) (return #f))

  (define vec1 (make-vector 26 0))
  (define vec2 (make-vector 26 0))

  (for ([i (in-range len1)])
    (vector-set! vec1 (- (char->integer (string-ref s1 i)) 97) 
                 (add1 (vector-ref vec1 (- (char->integer (string-ref s1 i)) 97))))
    (vector-set! vec2 (- (char->integer (string-ref s2 i)) 97) 
                 (add1 (vector-ref vec2 (- (char->integer (string-ref s2 i)) 97))))

  (define matches 0)
  (for ([i (in-range 26)])
    (when (= (vector-ref vec1 i) (vector-ref vec2 i))
      (set! matches (add1 matches))))

  (define left 0)
  (for ([right (in-range len1 len2)])
    (when (= matches 26) (return #t))

    (define index (- (char->integer (string-ref s2 right)) 97))
    (vector-set! vec2 index (add1 (vector-ref vec2 index)))
    (when (= (vector-ref vec2 index) (vector-ref vec1 index))
      (set! matches (add1 matches)))
    (when (= (add1 (vector-ref vec2 index)) (vector-ref vec1 index))
      (set! matches (sub1 matches)))

    (define left-index (- (char->integer (string-ref s2 left)) 97))
    (vector-set! vec2 left-index (sub1 (vector-ref vec2 left-index)))
    (when (= (vector-ref vec2 left-index) (vector-ref vec1 left-index))
      (set! matches (add1 matches)))
    (when (= (sub1 (vector-ref vec2 left-index)) (vector-ref vec1 left-index))
      (set! matches (sub1 matches)))

    (set! left (add1 left)))

  (= matches 26))