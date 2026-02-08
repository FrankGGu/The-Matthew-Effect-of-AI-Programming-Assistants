(define (h-index citations)
  (define n (length citations))
  (if (zero? n)
      0
      (let ([sorted-citations (sort citations >)])
        (define (find-h-index current-list i current-h)
          (if (empty? current-list)
              current-h
              (let ([h-candidate (+ i 1)])
                (if (>= (car current-list) h-candidate)
                    (find-h-index (cdr current-list) (+ i 1) h-candidate)
                    current-h))))
        (find-h-index sorted-citations 0 0))))