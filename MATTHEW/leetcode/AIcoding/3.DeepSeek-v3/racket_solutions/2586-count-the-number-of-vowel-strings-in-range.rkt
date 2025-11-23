(define/contract (count-vowel-strings words left right)
  (-> (listof string?) exact-integer? exact-integer? exact-integer?)
  (define vowels (set #\a #\e #\i #\o #\u))
  (let loop ([i left] [count 0])
    (if (> i right)
        count
        (let* ([word (list-ref words i)]
               [first-char (string-ref word 0)]
               [last-char (string-ref word (sub1 (string-length word)))])
          (loop (add1 i) 
                (if (and (set-member? vowels first-char) 
                         (set-member? vowels last-char))
                    (add1 count)
                    count))))))