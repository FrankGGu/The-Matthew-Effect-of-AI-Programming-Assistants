(define (count-matches w1 w2)
  (let loop ((i 0) (matches 0))
    (if (= i (string-length w1))
        matches
        (loop (+ i 1)
              (if (char=? (string-ref w1 i) (string-ref w2 i))
                  (+ matches 1)
                  matches)))))

(define (findSecretWord wordlist master)
  (let loop ((current-wordlist wordlist))
    (let* ((n (length current-wordlist))
           (best-word (cond
                        ((null? current-wordlist) (error "Empty wordlist, secret word not found."))
                        ((= n 1) (car current-wordlist))
                        (else
                         (let* ((min-max-group-size (+ n 1)) ; Initialize with value greater than any possible group size
                                (chosen-best-word (car current-wordlist))) ; Initialize with the first word as a default

                           (for-each (lambda (w-guess)
                                       (let* ((groups (make-hash))
                                              (_ (for-each (lambda (w-other)
                                                             (let ((matches (count-matches w-guess w-other)))
                                                               (hash-set! groups matches (cons w-other (hash-ref groups matches '())))))
                                                           current-wordlist))
                                              (max-group-size 0))

                                         (hash-for-each (lambda (k v)
                                                          (set! max-group-size (max max-group-size (length v))))
                                                        groups)

                                         (when (< max-group-size min-max-group-size)
                                           (set! min-max-group-size max-group-size)
                                           (set! chosen-best-word w-guess))))
                                     current-wordlist)
                           chosen-best-word))))
           (matches (master-guess master best-word)))
      (if (= matches 6)
          #t ; Secret word found
          (let ((next-wordlist
                 (filter (lambda (w)
                           (= (count-matches best-word w) matches))
                         current-wordlist)))
            (loop next-wordlist))))))