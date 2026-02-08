(define/contract (get-words-in-longest-subsequence n words groups)
  (-> exact-integer? (listof string?) (listof exact-integer?) (listof string?))
  (let loop ([i 1]
             [prev-group (car groups)]
             [prev-word (car words)]
             [result (list (car words))])
    (if (= i n)
        (reverse result)
        (let ([current-group (list-ref groups i)]
              [current-word (list-ref words i)])
          (if (not (= current-group prev-group))
              (loop (+ i 1) current-group current-word (cons current-word result))
              (loop (+ i 1) prev-group prev-word result))))))