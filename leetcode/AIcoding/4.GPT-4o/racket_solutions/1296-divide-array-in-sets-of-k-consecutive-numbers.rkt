(define (canDivideIntoSets nums k)
  (define sorted-nums (sort nums <))
  (define num-count (make-hash))

  (for-each (lambda (num) 
              (hash-set! num-count num (add1 (hash-ref num-count num 0)))) 
            sorted-nums)

  (for-each (lambda (num)
              (let loop ((i 0))
                (when (< i k)
                  (define current (add1 num))
                  (define count (hash-ref num-count num 0))
                  (when (< count 1) (set! num-count (hash-set! num-count num 0)))
                  (set! num-count (hash-set! num-count num (sub1 count)))
                  (loop (add1 i)))))
            sorted-nums)

  (for-each (lambda (num)
              (when (> (hash-ref num-count num 0) 0)
                (return #f)))
            sorted-nums)

  #t)

(define (divideArrayInSetsOfKConsecutiveNumbers nums k)
  (canDivideIntoSets nums k))