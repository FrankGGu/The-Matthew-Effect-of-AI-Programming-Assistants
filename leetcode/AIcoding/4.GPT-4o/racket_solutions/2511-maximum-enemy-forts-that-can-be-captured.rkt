(define (captureForts forts)
  (define (count-capturable forts)
    (define (aux forts count)
      (cond
        [(null? forts) 0]
        [(equal? (car forts) 1) (max count (aux (cdr forts) 0))]
        [(equal? (car forts) -1) (aux (cdr forts) (+ count 1))]
        [else (aux (cdr forts) count)]))
    (aux forts 0))

  (define left-capturable 
    (count-capturable (take forts (index-of forts 1))))
  (define right-capturable 
    (count-capturable (reverse (take (reverse forts) (index-of (reverse forts) -1)))))

  (max left-capturable right-capturable))

(captureForts '(0 0 1 0 -1 0 0))