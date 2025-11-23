(define (count-anagrams words)
  (define (factorial n)
    (if (<= n 1) 1 (* n (factorial (- n 1)))))

  (define (count-freqs word)
    (define freqs (make-hash))
    (for ([char (string->list word)])
      (hash-update! freqs char (lambda (x) (add1 x)) 0))
    freqs)

  (define (anagram-count freqs)
    (define total (apply + (hash-map freqs (lambda (k v) v))))
    (define denom (apply * (map (lambda (v) (factorial v)) (hash-values freqs))))
    (/ (factorial total) denom))

  (define (count-anagrams-in-word word)
    (anagram-count (count-freqs word)))

  (apply + (map count-anagrams-in-word words)))

(count-anagrams '("eat" "tea" "tan" "ate" "nat" "bat"))