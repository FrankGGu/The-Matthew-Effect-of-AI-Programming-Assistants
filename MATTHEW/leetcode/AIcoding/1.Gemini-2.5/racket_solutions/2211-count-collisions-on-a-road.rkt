(define (trim-left-L s)
  (let ([len (string-length s)])
    (let loop ([i 0])
      (cond
        [(= i len) ""]
        [(char=? (string-ref s i) #\L) (loop (+ i 1))]
        [else (substring s i len)]))))

(define (trim-right-R s)
  (let ([len (string-length s)])
    (let loop ([i (- len 1)])
      (cond
        [(< i 0) ""]
        [(char=? (string-ref s i) #\R) (loop (- i 1))]
        [else (substring s 0 (+ i 1))]))))

(define (count-collisions directions)
  (let* ([trimmed-left (trim-left-L directions)]
         [trimmed-both (trim-right-R trimmed-left)])
    (let loop ([i 0]
               [collisions 0]
               [len (string-length trimmed-both)])
      (cond
        [(= i len) collisions]
        [else
         (let ([char (string-ref trimmed-both i)])
           (loop (+ i 1)
                 (cond
                   [(or (char=? char #\R) (char=? char #\L)) (+ collisions 1)]
                   [else collisions])))]))))