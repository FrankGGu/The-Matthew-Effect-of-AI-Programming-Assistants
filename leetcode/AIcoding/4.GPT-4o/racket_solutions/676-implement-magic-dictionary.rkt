(define MagicDictionary
  (lambda ()
    (define dict '())
    (define (buildDict dictionary)
      (set! dict (map (lambda (word) (list word)) dictionary)))
    (define (search searchWord)
      (define (canChange? word)
        (let loop ((i 0) (changed #f))
          (cond
            [(= i (string-length word)) (and changed (not (equal? word searchWord)))]
            [else
             (let ((c (string-ref searchWord i))
                   (w (string-ref word i)))
               (loop (+ i 1) (or changed (not (equal? c w)))))])))
      (ormap canChange? dict))
    (lambda (method . args)
      (case method
        ((buildDict) (apply buildDict args))
        ((search) (apply search args))))))