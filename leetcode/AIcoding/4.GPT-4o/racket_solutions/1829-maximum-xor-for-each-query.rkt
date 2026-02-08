(define (maximumXOR nums queries)
  (define (build-trie nums)
    (define trie '())
    (for-each (lambda (num)
                (let loop ((node trie) (bit 30))
                  (if (< bit 0)
                      #t
                      (begin
                        (set! node (if (null? (list-ref node (if (zero? (bitwise-and num (expt 2 bit))) 0 1)))
                                       (vector (vector) (vector))
                                       (list-ref node (if (zero? (bitwise-and num (expt 2 bit))) 0 1))))
                        (loop node (- bit 1))))))
              nums)
    trie)

  (define (query-trie trie num)
    (define (loop node bit)
      (if (< bit 0)
          0
          (let* ((next (if (zero? (bitwise-and num (expt 2 bit))) 1 0))
                 (choice (if (null? (list-ref node next)) next (- next 1))))
            (+ (if (null? (list-ref node choice)) 0 (expt 2 bit)) (loop (list-ref node choice) (- bit 1))))))
    (loop trie 30))

  (define trie (build-trie nums))
  (map (lambda (q) (query-trie trie (cdr q))) queries))

(maximumXOR (vector 3 2 5 6) (vector (vector 3 1) (vector 5 2) (vector 7 3) (vector 2 4)))