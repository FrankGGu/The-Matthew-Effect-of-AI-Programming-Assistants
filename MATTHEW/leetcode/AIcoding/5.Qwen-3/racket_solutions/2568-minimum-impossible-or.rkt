(define (min-impossible-or nums)
  (define (count-bits n)
    (let loop ([n n] [cnt 0])
      (if (= n 0)
          cnt
          (loop (arithmetic-shift n -1) (+ cnt (bitwise-and n 1))))))

  (define (solve)
    (let ([bits (make-hash)])
      (for-each (lambda (x)
                  (let ([b (count-bits x)])
                    (hash-set! bits b #t)))
                nums)
      (let loop ([i 1])
        (if (hash-has-key? bits i)
            (loop (+ i 1))
            i))))

  (solve))