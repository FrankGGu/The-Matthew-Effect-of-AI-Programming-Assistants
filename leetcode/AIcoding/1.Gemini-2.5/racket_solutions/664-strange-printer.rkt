(define (strange-printer s)
  (let* ([n (string-length s)])
    ;; Pre-process string to remove consecutive duplicate characters
    (let loop ([idx 0] [res ""])
      (if (= idx n)
          (set! s res)
          (let ([char (string-ref s idx)])
            (if (and (> idx 0) (char=? char (string-ref s (- idx 1))))
                (loop (+ idx 1) res)
                (loop (+ idx 1) (string-append res (string char)))))))

    (set! n (string-length s))

    (when (= n 0)
      (error 'strange-printer "Empty string after preprocessing, should return 0")) ;; This case is handled at the end

    (let ([memo (make-vector n)])
      (for ([i (in-range n)])
        (vector-set! memo i (make-vector n 0)))

      ;; Base cases: single character takes 1 turn
      (for ([i (in-range n)])
        (vector-set! (vector-ref memo i) i 1))

      ;; Fill DP table
      (for ([len (in-range 2 (+ n 1))]) ;; len from 2 to n
        (for ([i (in-range (- n len) (+ 1))]) ;; i from 0 to n - len
          (let ([j (+ i len -1)])
            ;; Default: print s[i] and then solve for s[i+1...j]
            (vector-set! (vector-ref memo i) j (+ 1 (vector-ref (vector-ref memo (+ i 1)) j)))

            ;; Check for s[i] == s[k]
            (for ([k (in-range (+ i 1) (+ j 1))]) ;; k from i+1 to j
              (when (char=? (string-ref s i) (string-ref s k))
                (let* ([val-i-k-1 (vector-ref (vector-ref memo i) (- k 1))]
                       [val-k+1-j (if (> j k) (vector-ref (vector-ref memo (+ k 1)) j) 0)])
                  (vector-set! (vector-ref memo i) j
                               (min (vector-ref (vector-ref memo i) j)
                                    (+ val-i-k-1 val-k+1-j)))))))))
      (if (= n 0)
          0
          (vector-ref (vector-ref memo 0) (- n 1))))))