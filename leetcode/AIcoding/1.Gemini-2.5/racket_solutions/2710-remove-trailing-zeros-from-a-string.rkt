(define (remove-trailing-zeros num)
  (let* ((len (string-length num))
         (i (- len 1)))
    (let loop ((current-i i))
      (cond
        ((< current-i 0) "")
        ((char=? (string-ref num current-i) #\0) (loop (- current-i 1)))
        (else (substring num 0 (+ current-i 1)))))))