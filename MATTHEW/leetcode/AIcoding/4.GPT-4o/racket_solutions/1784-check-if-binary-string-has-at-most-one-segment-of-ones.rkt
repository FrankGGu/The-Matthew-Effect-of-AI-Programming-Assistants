(define (checkOnesSegment s)
  (let loop ((i 0) (count 0))
    (cond
      ((= i (string-length s)) (= count 1))
      ((char=? (string-ref s i) #\1) 
       (if (= count 0)
           (loop (1+ i) 1)
           (loop (1+ i) count)))
      (else 
       (if (= count 1)
           (loop (1+ i) count)
           (loop (1+ i) 0))))))

(checkOnesSegment "1001")