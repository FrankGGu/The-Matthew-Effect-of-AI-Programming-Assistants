(define (number-of-subarrays-that-match-a-pattern-ii nums pattern)
  (let* ([n (length nums)]
         [m (length pattern)]
         [text-comparisons-len (- n 1)]
         [nums-vec (list->vector nums)]
         [pattern-vec (list->vector pattern)]
         [text-comparisons (make-vector text-comparisons-len)])

    (for ([i (in-range text-comparisons-len)])
      (let ([val1 (vector-ref nums-vec i)]
            [val2 (vector-ref nums-vec (+ i 1))])
        (vector-set! text-comparisons i
                     (cond
                       [(> val2 val1) 1]
                       [(< val2 val1) -1]
                       [else 0]))))

    (let* ([lps (make-vector m 0)]
           [count 0])

      (let loop-lps ([len 0]
                     [i 1])
        (when (< i m)
          (cond
            [(equal? (vector-ref pattern-vec i) (vector-ref pattern-vec len))
             (vector-set! lps i (+ len 1))
             (loop-lps (+ len 1) (+ i 1))]
            [(= len 0)
             (vector-set! lps i 0)
             (loop-lps 0 (+ i 1))]
            [else
             (set! len (vector-ref lps (- len 1)))
             (loop-lps len i)])))

      (let loop-search ([i 0]
                        [j 0])
        (when (< i text-comparisons-len)
          (cond
            [(equal? (vector-ref text-comparisons i) (vector-ref pattern-vec j))
             (set! i (+ i 1))
             (set! j (+ j 1))]
            [else
             (when (> j 0)
               (set! j (vector-ref lps (- j 1))))
             (unless (> j 0)
               (set! i (+ i 1)))])

          (when (= j m)
            (set! count (+ count 1))
            (set! j (vector-ref lps (- j 1))))
          (loop-search i j)))
      count)))