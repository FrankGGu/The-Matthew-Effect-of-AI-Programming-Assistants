(define (smallest-k-length-subsequence s k letter)
  (define letter-count (count (lambda (x) (equal? x letter)) s))
  (define result '())
  (define to-push 0)

  (for-each (lambda (char)
              (if (equal? char letter)
                  (begin
                    (set! to-push (+ to-push 1))
                    (set! letter-count (- letter-count 1))))
                  (begin
                    (while (and (not (null? result))
                                (> (length result) (- k 1))
                                (not (equal? (car (reverse result)) letter)))
                      (set! result (cdr (reverse result))))
                    (set! result (cons char result)))))
            (string->list s))

  (while (and (not (null? result))
              (> (length result) k))
    (set! result (cdr result)))

  (define final (reverse (cons letter (take result (- k to-push)))))
  (apply string final))