(define (is-vowel? c)
  (member c '(a e i o u)))

(define (count-vowel-strings words left right)
  (let loop ([i left] [count 0])
    (if (> i right)
        count
        (let ([word (list->string (list-ref words i))])
          (if (and (is-vowel? (string-ref word 0)) (is-vowel? (string-ref word (- (string-length word) 1))))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count))))))