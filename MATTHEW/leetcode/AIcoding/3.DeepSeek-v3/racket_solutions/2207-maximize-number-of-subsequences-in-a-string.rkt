(define (maximum-subsequence-count text pattern)
  (let* ([ch1 (string-ref pattern 0)]
         [ch2 (string-ref pattern 1)]
         [count1 0]
         [count2 0]
         [res 0])
    (for ([ch (in-string text)])
      (when (char=? ch ch2)
        (set! res (+ res count1))
        (set! count2 (+ count2 1)))
      (when (char=? ch ch1)
        (set! count1 (+ count1 1))))
    (+ res (max count1 count2))))