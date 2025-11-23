(define/contract (num-smallest-char s)
  (-> string? exact-integer?)
  (let* ([chars (string->list s)]
         [smallest (apply min chars)])
    (count (lambda (c) (char=? c smallest)) chars)))

(define/contract (freq-smallest words)
  (-> (listof string?) (listof exact-integer?))
  (map num-smallest-char words))

(define/contract (num-less-than-or-equal nums num)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (count (lambda (n) (<= n num)) nums))

(define/contract (num-smallest-by-frequency queries words)
  (-> (listof string?) (listof string?) (listof exact-integer?))
  (let ([word-freqs (freq-smallest words)]
        [query-freqs (freq-smallest queries)])
    (map (lambda (q) (num-less-than-or-equal word-freqs q)) query-freqs)))