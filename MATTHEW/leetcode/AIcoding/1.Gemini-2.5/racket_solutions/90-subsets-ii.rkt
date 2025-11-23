(define (subsets-with-dup nums)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define result '())

  (define (backtrack current-subset start-index)
    (set! result (cons (reverse current-subset) result))

    (for ([i (in-range start-index n)])
      (unless (and (> i start-index)
                   (= (list-ref sorted-nums i) (list-ref sorted-nums (- i 1))))
        (backtrack (cons (list-ref sorted-nums i) current-subset)
                   (+ i 1)))))

  (backtrack '() 0)
  (reverse result))