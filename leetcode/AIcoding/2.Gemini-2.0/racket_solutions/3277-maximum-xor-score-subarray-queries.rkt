(define (maximum-xor-score-subarray-queries nums queries)
  (define n (length nums))
  (define m (length queries))
  (define queries-with-index (map (lambda (i q) (cons q i)) (range m) queries))
  (define sorted-queries (sort queries-with-index (lambda (a b) (< (car a) (car b)))))
  (define ans (make-vector m -1))

  (define (trie-insert trie num)
    (let loop ([node trie] [bit 30])
      (if (< bit 0)
          void
          (let ([bit-val (if (zero? (bitwise-and num (arithmetic-shift 1 bit))) 0 1)])
            (if (null? (hash-ref node bit-val #f))
                (hash-set! node bit-val (make-hash))
                void)
            (loop (hash-ref node bit-val) (sub1 bit))))))

  (define (trie-max-xor trie num)
    (let loop ([node trie] [bit 30] [xor-sum 0])
      (if (< bit 0)
          xor-sum
          (let ([bit-val (if (zero? (bitwise-and num (arithmetic-shift 1 bit))) 0 1)])
            (let ([opposite-bit (if (zero? bit-val) 1 0)])
              (if (hash-has-key? node opposite-bit)
                  (loop (hash-ref node opposite-bit) (sub1 bit) (bitwise-ior xor-sum (arithmetic-shift 1 bit)))
                  (loop (hash-ref node bit-val) (sub1 bit) xor-sum)))))))

  (let loop ([i 0] [current-max 0] [trie (make-hash)] [j 0])
    (if (= j m)
        ans
        (let ([current-query (list-ref sorted-queries j)])
          (let ([limit (car current-query)]
                [index (cdr current-query)])
            (begin
              (for ([k (in-range i n)])
                (when (<= (list-ref nums k) limit)
                  (trie-insert trie (list-ref nums k))))
              (if (hash-empty? trie)
                  (vector-set! ans index -1)
                  (vector-set! ans index (trie-max-xor trie limit)))
              (loop i current-max trie (add1 j))))))))
  )