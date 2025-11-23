(define (longestPalindrome words)
  (define word-count (make-hash))
  (define single-letters '())
  (for-each (lambda (word)
              (hash-set! word-count word (add1 (hash-ref word-count word 0)))
              (when (= (string-length word) 2)
                (let* ((rev (string-append (string-ref word 1) (string-ref word 0)))
                       (count (hash-ref word-count rev 0)))
                  (when (> count 0)
                    (hash-set! word-count rev (sub1 count))
                    (set! single-letters (cons word single-letters))))))
            words)

  (define total-length
    (apply + (map (lambda (k) (* 2 (hash-ref word-count k 0))) (hash-keys word-count))))

  (if (null? single-letters)
      total-length
      (+ total-length 2)))