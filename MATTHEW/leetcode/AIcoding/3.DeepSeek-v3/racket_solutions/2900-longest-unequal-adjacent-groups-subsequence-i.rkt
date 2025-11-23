(define/contract (get-words-in-longest-subsequence n words groups)
  (-> exact-integer? (listof string?) (listof exact-integer?) (listof string?))
  (let loop ([i 1]
             [current (list (car words))]
             [current-groups (list (car groups))]
             [max-len 1]
             [result (list (car words))])
    (if (>= i n)
        result
        (let ([last-group (car current-groups)]
              [current-group (list-ref groups i)])
            (if (not (= last-group current-group))
                (let ([new-current (cons (list-ref words i) current)]
                      [new-len (+ 1 (length current))])
                  (if (> new-len max-len)
                      (loop (+ i 1) new-current (cons current-group current-groups) new-len new-current)
                      (loop (+ i 1) new-current (cons current-group current-groups) max-len result)))
                (loop (+ i 1) (list (list-ref words i)) (list current-group) max-len result))))))