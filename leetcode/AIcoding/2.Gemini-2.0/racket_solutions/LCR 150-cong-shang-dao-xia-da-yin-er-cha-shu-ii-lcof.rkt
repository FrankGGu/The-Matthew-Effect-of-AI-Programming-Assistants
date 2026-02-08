(define (record-decoration records)
  (define (helper records acc)
    (cond
      [(empty? records) acc]
      [else
       (let* ([record (car records)]
              [start (car record)]
              [end (cadr record)]
              [color (caddr record)])
         (helper (cdr records)
                 (let loop ([i start] [new-acc acc])
                   (cond
                     [(> i end) new-acc]
                     [else
                      (let ([found (ormap (lambda (x) (equal? (car x) i)) new-acc)])
                        (if found
                            (let ([updated-acc (map (lambda (x)
                                                     (if (equal? (car x) i)
                                                         (list (car x) color)
                                                         x))
                                                   new-acc)])
                              (loop (+ i 1) updated-acc))
                            (loop (+ i 1) (append new-acc (list (list i color)))))))]))))]))
  (sort (helper records '()) < #:key car))