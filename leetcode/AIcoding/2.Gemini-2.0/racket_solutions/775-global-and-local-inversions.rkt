(define (is-global-and-local-inversions nums)
  (let* ([n (length nums)]
         [global-inversions (for/sum ([i (in-range n)] [j (in-range (+ i 1) n)])
                                 (if (> (list-ref nums i) (list-ref nums j)) 1 0))]
         [local-inversions (for/sum ([i (in-range (- n 1))])
                                (if (> (list-ref nums i) (list-ref nums (+ i 1))) 1 0))])
    (= global-inversions local-inversions)))