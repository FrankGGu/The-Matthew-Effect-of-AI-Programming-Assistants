(define (eliminate-game n)
  (let loop ([start 1] [len n] [step 1] [left->right #t])
    (if (= len 1)
        start
        (if left->right
            (loop (+ start step) (quotient len 2) (* step 2) (not left->right))
            (loop (if (odd? len) (+ start step) start) (quotient len 2) (* step 2) (not left->right))))))