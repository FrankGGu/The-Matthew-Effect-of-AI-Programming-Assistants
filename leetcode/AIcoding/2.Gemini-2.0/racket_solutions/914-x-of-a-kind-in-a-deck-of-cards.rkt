(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (has-groups cards)
  (let* ((counts (hash))
         (process-card (lambda (card)
                          (hash-update! counts card (lambda (v) (+ v 1)) 1))))
    (for-each process-card cards)
    (let ((values (hash-values counts)))
      (if (null? values)
          #f
          (let ((first-val (car values)))
            (let loop ((rest (cdr values)) (g first-val))
              (cond
                ((null? rest)
                 (>= g 2))
                (else
                 (let ((new-g (gcd g (car rest))))
                   (loop (cdr rest) new-g))))))))))