(define (scoreOfParentheses s)
  (define (helper s start end)
    (if (= start end)
        0
        (let loop ((i start) (balance 0) (last 0) (score 0))
          (cond
            ((= i end) score)
            ((char=? (string-ref s i) #\() (loop (+ i 1) (+ balance 1) last score))
            ((char=? (string-ref s i) #\)) 
             (if (= balance 1)
                 (loop (+ i 1) (- balance 1) (+ last 1) (+ score (+ 1 last)))
                 (loop (+ i 1) (- balance 1) 0 score)))
            (else (loop (+ i 1) balance last score))))))
  (helper s 0 (string-length s)))