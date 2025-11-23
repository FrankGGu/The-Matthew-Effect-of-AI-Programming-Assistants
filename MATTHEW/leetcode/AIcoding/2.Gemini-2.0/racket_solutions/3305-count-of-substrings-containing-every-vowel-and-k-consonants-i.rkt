(define (count-substrings-with-vowels-and-consonants s k)
  (define (is-vowel? c)
    (member c '(#\a #\e #\i #\o #\u)))

  (define (count-consonants sub)
    (count (lambda (c) (not (is-vowel? c))) (string->list sub)))

  (define (has-all-vowels? sub)
    (and (string-contains? sub "a")
         (string-contains? sub "e")
         (string-contains? sub "i")
         (string-contains? sub "o")
         (string-contains? sub "u")))

  (define n (string-length s))
  (define count 0)

  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (define sub (substring s i (+ j 1)))
      (when (and (has-all-vowels? sub) (= (count-consonants sub) k))
        (set! count (+ count 1)))))

  count)