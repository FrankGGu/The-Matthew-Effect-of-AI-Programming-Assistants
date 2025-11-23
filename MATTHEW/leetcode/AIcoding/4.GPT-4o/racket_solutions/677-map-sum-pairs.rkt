(define MapSum
  (lambda ()
    (define key-value (make-hash))
    (define total (make-hash))

    (define (insert key val)
      (let* ((old-val (hash-ref key-value key 0))
             (diff (- val old-val)))
        (hash-set! key-value key val)
        (for-each (lambda (k)
                    (hash-set! total k (+ (hash-ref total k 0) diff)))
                  (filter (lambda (x) (string-prefix? key x))
                          (hash-keys key-value)))))

    (define (sum prefix)
      (hash-ref total prefix 0))

    (define (map-sum)
      (lambda (cmd)
        (cond
          ((equal? (car cmd) 'insert) (insert (cadr cmd) (caddr cmd)))
          ((equal? (car cmd) 'sum) (sum (cadr cmd))))))

    (map-sum)))

(define ms (MapSum))
((ms) 'insert "apple" 3)
((ms) 'sum "ap")  ; returns 3
((ms) 'insert "app" 2)
((ms) 'sum "ap")  ; returns 5