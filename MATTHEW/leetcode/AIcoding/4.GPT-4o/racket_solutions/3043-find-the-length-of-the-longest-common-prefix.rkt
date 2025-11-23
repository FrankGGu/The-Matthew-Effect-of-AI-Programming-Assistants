(define (longestCommonPrefix strs)
  (if (null? strs)
      ""
      (let loop ((prefix (car strs)) (rest (cdr strs)))
        (if (null? rest)
            prefix
            (let ((next (car rest)))
              (let loop2 ((i 0))
                (if (or (>= i (string-length prefix)) 
                        (>= i (string-length next)) 
                        (not (equal? (string-ref prefix i) (string-ref next i))))
                    (substring prefix 0 i)
                    (loop (substring prefix 0 (+ i 1)) (cdr rest)) 
                    (loop2 (+ i 1)))))))))

(define (longestCommonPrefix strs)
  (if (null? strs)
      ""
      (let loop ((prefix (car strs)) (rest (cdr strs)))
        (if (null? rest)
            prefix
            (let ((next (car rest)))
              (let loop2 ((i 0))
                (if (or (>= i (string-length prefix)) 
                        (>= i (string-length next)) 
                        (not (equal? (string-ref prefix i) (string-ref next i))))
                    (substring prefix 0 i)
                    (loop (substring prefix 0 (+ i 1)) (cdr rest)) 
                    (loop2 (+ i 1)))))))))