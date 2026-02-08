(define (count-time time)
  (let* ((h1 (string-ref time 0))
         (h2 (string-ref time 1))
         (m1 (string-ref time 3))
         (m2 (string-ref time 4))
         (h-options (cond [(and (char=? h1 #\?) (char=? h2 #\?)) 24]
                         [(char=? h1 #\?) (if (char<=? h2 #\3) 3 2)]
                         [(char=? h2 #\?) (if (char=? h1 #\2) 4 10)]
                         [else 1]))
         (m-options (cond [(and (char=? m1 #\?) (char=? m2 #\?)) 60]
                         [(char=? m1 #\?) 6]
                         [(char=? m2 #\?) 10]
                         [else 1])))
    (* h-options m-options)))