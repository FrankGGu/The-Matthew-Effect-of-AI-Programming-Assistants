(define (count-substrings-with-vowels-and-consonants s k)
  (define (is-vowel? c)
    (member c '(a e i o u)))

  (define (count-consonants str)
    (count (lambda (c) (not (is-vowel? c))) (string->list str)))

  (define (has-all-vowels? str)
    (and (string-contains? str "a")
         (string-contains? str "e")
         (string-contains? str "i")
         (string-contains? str "o")
         (string-contains? str "u")))

  (define n (string-length s))
  (define count (box 0))

  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (let ([sub (substring s i (+ j 1))])
        (when (and (has-all-vowels? sub)
                   (>= (count-consonants sub) k))
          (set-box! count (+ (unbox count) 1))))))

  (unbox count))