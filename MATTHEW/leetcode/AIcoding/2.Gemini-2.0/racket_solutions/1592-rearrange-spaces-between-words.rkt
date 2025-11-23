(define (rearrange-spaces text)
  (define words (string-split text))
  (define num-words (length (filter (λ (x) (not (equal? x ""))) words)))
  (define spaces (count #\space (string->list text)))

  (cond
    [(equal? num-words 1)
     (string-append (car (filter (λ (x) (not (equal? x ""))) words)) (make-string spaces #\space))]
    [else
     (define base-spaces (floor (/ spaces (- num-words 1))))
     (define extra-spaces (modulo spaces (- num-words 1)))
     (string-join (append (map (λ (x) (string-append x (make-string base-spaces #\space))) (drop-right (filter (λ (x) (not (equal? x ""))) words) 1))
                           (list (car (reverse (filter (λ (x) (not (equal? x ""))) words)))))
                  (make-string 0 #\space))
     (string-append (string-join (append (map (λ (x) (string-append x (make-string base-spaces #\space))) (drop-right (filter (λ (x) (not (equal? x ""))) words) 1))
                           (list (car (reverse (filter (λ (x) (not (equal? x ""))) words)))))
                  (make-string 0 #\space)) (make-string extra-spaces #\space))]))