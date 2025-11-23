(define (is-prefix-of-array s words)
  (let loop ((current-prefix "")
             (remaining-words words))
    (cond
      ((string=? current-prefix s) #t)
      ((empty? remaining-words) #f)
      ((> (string-length current-prefix) (string-length s)) #f)
      (else
       (let ((next-word (first remaining-words)))
         (loop (string-append current-prefix next-word)
               (rest remaining-words)))))))