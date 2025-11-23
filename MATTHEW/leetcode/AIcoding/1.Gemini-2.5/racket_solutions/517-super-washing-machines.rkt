(define (super-washing-machines dresses)
  (let* ([n (length dresses)]
         [total-dresses (apply + dresses)])
    (if (not (zero? (remainder total-dresses n)))
        -1
        (let* ([target (quotient total-dresses n)]
               [max-moves 0]
               [current-balance-sum 0])
          (for ([dress dresses])
            (let* ([diff (- dress target)])
              (set! max-moves (max max-moves diff))
              (set! current-balance-sum (+ current-balance-sum diff))
              (set! max-moves (max max-moves (abs current-balance-sum)))))
          max-moves))))