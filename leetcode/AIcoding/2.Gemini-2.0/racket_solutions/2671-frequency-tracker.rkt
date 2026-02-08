(define frequency-tracker%
  (class object%
    (init)
    (define numbers (make-hash))
    (define frequencies (make-hash))

    (define/public (add number)
      (let ((old-freq (hash-ref numbers number 0)))
        (when (> old-freq 0)
          (hash-update! frequencies old-freq (lambda (v) (sub1 v)) 0))
        (hash-update! numbers number (lambda (v) (add1 v)) 1)
        (hash-update! frequencies (add1 old-freq) (lambda (v) (add1 v)) 1)))

    (define/public (delete-one number)
      (if (hash-has-key? numbers number)
          (let ((old-freq (hash-ref numbers number 0)))
            (if (> old-freq 0)
                (begin
                  (hash-update! frequencies old-freq (lambda (v) (sub1 v)) 0)
                  (hash-update! numbers number (lambda (v) (sub1 v)) 0)
                  (let ((new-freq (hash-ref numbers number 0)))
                    (when (> new-freq 0)
                      (hash-update! frequencies new-freq (lambda (v) (add1 v)) 1))
                    #t))
                #f))
          #f))

    (define/public (has-frequency frequency)
      (> (hash-ref frequencies frequency 0) 0))))