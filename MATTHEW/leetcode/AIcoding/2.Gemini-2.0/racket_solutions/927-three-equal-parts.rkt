(define (three-equal-parts arr)
  (let* ((n (length arr))
         (ones (count (lambda (x) (= x 1)) arr))
         (part-ones (quotient ones 3)))
    (cond
      [(= ones 0) (list 0 (- n 2))]
      [(not (= (remainder ones 3) 0)) (list -1 -1)]
      [else
       (let loop ([i 0] [count 0])
         (if (= count part-ones)
             i
             (if (= (list-ref arr i) 1)
                 (loop (+ i 1) (+ count 1))
                 (loop (+ i 1) count))))
       => (lambda (first-end)
            (let loop ([i (+ first-end 1)] [count 0])
              (if (= count part-ones)
                  i
                  (if (= (list-ref arr i) 1)
                      (loop (+ i 1) (+ count 1))
                      (loop (+ i 1) count))))
            => (lambda (second-end)
                 (let* ((first-start 0)
                        (second-start (+ first-end 1))
                        (third-start (+ second-end 1)))
                   (let compare ([i first-start] [j second-start] [k third-start])
                     (cond
                       [(>= k n) (list first-end second-end)]
                       [(>= j second-end) (list first-end second-end)]
                       [(>= i first-end) (list first-end second-end)]
                       [(= (list-ref arr i) (list-ref arr j) (list-ref arr k))
                        (compare (+ i 1) (+ j 1) (+ k 1))]
                       [else (list -1 -1)])))))])))