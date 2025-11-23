(define (open-lock deadends target)
  (let ([dead-set (set deadends)]
        [visited (make-hash)]
        [q (make-queue)])
    (when (set-member? dead-set "0000")
      (return -1))
    (queue-enqueue! q (cons "0000" 0))
    (hash-set! visited "0000" #t)
    (let loop ()
      (if (queue-empty? q)
          -1
          (let* ([curr (queue-dequeue! q)]
                 [lock (car curr)]
                 [steps (cdr curr)])
            (if (string=? lock target)
                steps
                (let* ([neighbors (list
                                  (string-append (substring lock 0 0) (number->string (modulo (+ 1 (string->number (substring lock 0 1))) 10)) (substring lock 1 4))
                                  (string-append (substring lock 0 0) (number->string (modulo (- (string->number (substring lock 0 1)) 1) 10)) (substring lock 1 4))
                                  (string-append (substring lock 0 1) (number->string (modulo (+ 1 (string->number (substring lock 1 2))) 10)) (substring lock 2 4))
                                  (string-append (substring lock 0 1) (number->string (modulo (- (string->number (substring lock 1 2)) 1) 10)) (substring lock 2 4))
                                  (string-append (substring lock 0 2) (number->string (modulo (+ 1 (string->number (substring lock 2 3))) 10)) (substring lock 3 4))
                                  (string-append (substring lock 0 2) (number->string (modulo (- (string->number (substring lock 2 3)) 1) 10)) (substring lock 3 4))
                                  (string-append (substring lock 0 3) (number->string (modulo (+ 1 (string->number (substring lock 3 4))) 10)))
                                  (string-append (substring lock 0 3) (number->string (modulo (- (string->number (substring lock 3 4)) 1) 10))))])
                  (for-each (lambda (neighbor)
                              (when (and (not (set-member? dead-set neighbor))
                                         (not (hash-has-key? visited neighbor)))
                                (queue-enqueue! q (cons neighbor (+ steps 1)))
                                (hash-set! visited neighbor #t)))
                            neighbors)
                  (loop))))))))