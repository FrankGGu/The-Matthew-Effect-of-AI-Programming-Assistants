(define (count-pairs nums low high)
  (define (count-less x)
    (let loop ([i 0] [res 0] [trie (make-hash)])
      (if (>= i (length nums))
          res
          (let* ([num (list-ref nums i)]
                 [node trie]
                 [current-res 0])
            (for ([bit (in-range 14 -1 -1)])
              (let* ([b (bitwise-bit-field num bit (add1 bit))]
                     [desired (bitwise-bit-field x bit (add1 bit))]
                     [key (bitwise-xor b desired)])
                (when (hash-has-key? node key)
                  (set! current-res (+ current-res (hash-ref (hash-ref node key) 'count 0)))
                (set! node (hash-ref node b (make-hash)))))
            (loop (add1 i) (+ res current-res) 
                  (let ([new-node (hash-ref trie (bitwise-bit-field num 14 15) (make-hash))])
                    (hash-set! trie (bitwise-bit-field num 14 15) new-node)
                  trie))))
  (- (count-less (add1 high)) (count-less low)))