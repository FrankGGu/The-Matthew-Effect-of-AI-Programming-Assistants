(define (maximum-enemy-forts forts)
  (define n (vector-length forts))

  (define-values (max-captured _last-idx _last-val)
    (for/fold ([current-max-captured 0]
               [last-idx #f] ; Stores the index of the last non-zero fort encountered
               [last-val #f]) ; Stores the value (1 or -1) of the last non-zero fort encountered
              ([i (in-range n)])
      (let ([fort-at-i (vector-ref forts i)])
        (cond
          [(= fort-at-i 0)
           ; If the current fort is empty, continue with the current state
           (values current-max-captured last-idx last-val)]

          [else ; fort-at-i is either 1 or -1
           (if (and last-idx (not (= fort-at-i last-val)))
               ; If we have seen a previous non-zero fort AND its type is opposite to the current fort
               ; Calculate the number of captured empty forts and update the maximum
               (values (max current-max-captured (- i last-idx 1))
                       i
                       fort-at-i)
               ; Otherwise (either no previous non-zero fort, or it's of the same type)
               ; Just update the last-idx and last-val to the current fort
               (values current-max-captured
                       i
                       fort-at-i))])))
  max-captured)