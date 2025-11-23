(define (beautiful-towers-ii heights)
  (define n (length heights))
  (if (= n 0)
      0
      (begin
        (define left-sums (make-vector n 0))
        (define right-sums (make-vector n 0))

        ;; Calculate left-sums
        (define stack '()) ; Stores indices
        (define current-left-sum 0)
        (for ([i (in-range n)])
          (define h_i (list-ref heights i))

          ;; Pop elements from stack that are greater than h_i
          (let loop-pop-left ([s stack] [cs current-left-sum])
            (if (and (not (null? s)) (> (list-ref heights (car s)) h_i))
                (let ([top-idx (car s)])
                  (loop-pop-left (cdr s)
                                 (- cs (* (list-ref heights top-idx)
                                          (- top-idx (if (null? (cdr s)) -1 (car (cdr s))))))))
                (begin
                  (set! stack s)
                  (set! current-left-sum cs))))

          ;; Calculate new sum and push current index
          (define prev-idx (if (null? stack) -1 (car stack)))
          (set! current-left-sum (+ current-left-sum (* h_i (- i prev-idx))))
          (vector-set! left-sums i current-left-sum)
          (set! stack (cons i stack)))

        ;; Calculate right-sums
        (set! stack '()) ; Reset stack
        (define current-right-sum 0)
        (for ([i (in-range (- n 1) -1 -1)]) ; Iterate from n-1 down to 0
          (define h_i (list-ref heights i))

          ;; Pop elements from stack that are greater than h_i
          (let loop-pop-right ([s stack] [cs current-right-sum])
            (if (and (not (null? s)) (> (list-ref heights (car s)) h_i))
                (let ([top-idx (car s)])
                  (loop-pop-right (cdr s)
                                  (- cs (* (list-ref heights top-idx)
                                           (- (if (null? (cdr s)) n (car (cdr s))) top-idx)))))
                (begin
                  (set! stack s)
                  (set! current-right-sum cs))))

          ;; Calculate new sum and push current index
          (define next-idx (if (null? stack) n (car stack)))
          (set! current-right-sum (+ current-right-sum (* h_i (- next-idx i))))
          (vector-set! right-sums i current-right-sum)
          (set! stack (cons i stack)))

        ;; Calculate max total sum
        (define max-total-sum 0)
        (for ([i (in-range n)])
          (define h_i (list-ref heights i))
          (set! max-total-sum (max max-total-sum
                                   (+ (vector-ref left-sums i)
                                      (vector-ref right-sums i)
                                      (- h_i))))) ; subtract h_i because it's counted twice
        max-total-sum)))