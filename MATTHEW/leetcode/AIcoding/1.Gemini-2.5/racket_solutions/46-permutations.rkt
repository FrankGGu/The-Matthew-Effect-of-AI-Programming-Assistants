(define (permute nums)
  (define (backtrack current-perm remaining-nums)
    (if (empty? remaining-nums)
        (list current-perm)
        (apply append
               (for/list ([i (range (length remaining-nums))])
                 (let* ([num (list-ref remaining-nums i)]
                        [new-remaining (append (take remaining-nums i) (drop remaining-nums (+ i 1)))])
                   (backtrack (append current-perm (list num)) new-remaining))))))
  (backtrack '() nums))