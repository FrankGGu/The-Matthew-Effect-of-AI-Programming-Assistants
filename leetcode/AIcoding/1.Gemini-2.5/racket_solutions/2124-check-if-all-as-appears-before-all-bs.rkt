(define (check-if-all-as-appear-before-all-bs s)
  (let ((len (string-length s)))
    (let loop ((i 0) (found-b-already? #f))
      (if (= i len)
          #t
          (let ((current-char (string-ref s i)))
            (cond
              ((char=? current-char #\a)
               (if found-b-already?
                   #f
                   (loop (+ i 1) #f)))
              ((char=? current-char #\b)
               (loop (+ i 1) #t))
              (else ; This case should not be reached based on problem constraints (only 'a' or 'b')
               (loop (+ i 1) found-b-already?))))))))