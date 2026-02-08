(define (count-vowels s)
  (string-count (regexp "[aeiou]") s))

(define (count-consonants s)
  (- (string-length s) (count-vowels s)))

(define (count-beautiful-substrings-ii s k)
  (let* ([n (string-length s)]
         [prefix-vowels (make-vector (add1 n) 0)]
         [prefix-consonants (make-vector (add1 n) 0)])
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix-vowels i (+ (vector-ref prefix-vowels (sub1 i))
                                        (if (regexp-match? (regexp "[aeiou]") (substring s (sub1 i) i)) 1 0)))
      (vector-set! prefix-consonants i (+ (vector-ref prefix-consonants (sub1 i))
                                          (if (not (regexp-match? (regexp "[aeiou]") (substring s (sub1 i) i))) 1 0))))
    (let loop ([i 0]
               [count 0])
      (if (= i n)
          count
          (let loop2 ([j (add1 i)])
            (if (> j n)
                (loop (add1 i) count)
                (let* ([vowels (- (vector-ref prefix-vowels j) (vector-ref prefix-vowels i))]
                       [consonants (- (vector-ref prefix-consonants j) (vector-ref prefix-consonants i))])
                  (if (and (= vowels consonants) (= (remainder (* vowels consonants) k) 0))
                      (loop2 (add1 j) (add1 count))
                      (loop2 (add1 j) count)))))))))