(define (maximum-unique-subarray sum nums)
  (let loop ([left 0]
             [right 0]
             [current-sum 0]
             [max-sum 0]
             [seen (make-hash)])
    (cond
      [(>= right (length nums))
       max-sum]
      [else
       (let ([num (list-ref nums right)])
         (cond
           [(hash-has-key? seen num)
            (let loop2 ([l left]
                        [cs current-sum])
              (let ([left-num (list-ref nums l)])
                (cond
                  [(= left-num num)
                   (hash-remove! seen left-num)
                   (loop (+ l 1) right (- cs left-num) max-sum seen)]
                  [else
                   (hash-remove! seen left-num)
                   (loop2 (+ l 1) (- cs left-num))])))]
           [else
            (hash-set! seen num #t)
            (let ([new-sum (+ current-sum num)])
              (loop left (+ right 1) new-sum (max max-sum new-sum) seen))]))])))