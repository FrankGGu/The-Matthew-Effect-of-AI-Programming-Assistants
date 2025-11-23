(define/contract (duplicate-zeros arr)
  (-> (listof exact-integer?) void?)
  (let loop ([i 0] [n (length arr)])
    (when (< i n)
      (if (zero? (list-ref arr i))
          (begin
            (set! arr (append (take arr i) (list 0) (drop arr i)))
            (loop (+ i 2) (+ n 1)))
          (loop (+ i 1) n)))))