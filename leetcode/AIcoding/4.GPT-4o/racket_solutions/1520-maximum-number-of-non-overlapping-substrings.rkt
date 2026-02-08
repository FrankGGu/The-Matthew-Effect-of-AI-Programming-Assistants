(define (max-num-of-non-overlapping-substrings s)
  (define n (string-length s))
  (define ends (make-vector n -1))
  (define last (make-vector 26 -1))

  (for ([i (in-range n)])
    (define idx (- (char->integer (string-ref s i)) (char->integer #\a)))
    (vector-set! last idx i)
    (define start (if (= i 0) 0 (vector-ref ends (sub1 i))))
    (when (or (= start 0) (<= start i))
      (vector-set! ends i (max (vector-ref ends i) (vector-ref last idx)))))

  (define result '())
  (define i 0)
  (while (< i n)
    (when (not (= (vector-ref ends i) -1))
      (define j (vector-ref ends i))
      (set! result (cons (substring s i (add1 j)) result))
      (set! i (add1 j))
      (continue))
    (set! i (add1 i)))

  (reverse result))

(define (maxNumOfNonOverlappingSubstrings s)
  (let* ([substrings (max-num-of-non-overlapping-substrings s)]
         [lengths (map string-length substrings)])
    (if (null? lengths)
        0
        (apply + lengths))))