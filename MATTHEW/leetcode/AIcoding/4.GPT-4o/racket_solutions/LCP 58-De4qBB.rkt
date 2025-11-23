(define (canFormArray arr pieces)
  (define piece-map (foldl (lambda (piece acc)
                              (hash-set! acc (car piece) (cdr piece)))
                            (make-hash)
                            pieces))
  (define (helper lst)
    (cond
      [(null? lst) #t]
      [(hash-has-key? piece-map (car lst))
       (let* ((piece (hash-ref piece-map (car lst)))
              (piece-length (length piece)))
         (if (equal? (take lst piece-length) piece)
             (helper (drop lst piece-length))
             #f))]
      [else #f]))
  (helper arr))