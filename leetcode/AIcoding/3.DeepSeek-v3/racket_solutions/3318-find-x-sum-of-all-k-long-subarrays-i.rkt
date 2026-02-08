(define/contract (sum-of-k-subarrays nums k x)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [window (take nums k)]
         [sums (list (apply + window))])
    (for ([i (in-range 1 (- n k -1))])
      (set! window (append (cdr window) (list (list-ref nums (+ i k -1)))))
      (set! sums (cons (apply + window) sums)))
    (let ([sorted-sums (sort sums <)])
      (apply + (take (sort sums <) x))))