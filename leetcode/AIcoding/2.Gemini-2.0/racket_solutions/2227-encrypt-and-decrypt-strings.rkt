(define (encrypt key values word)
  (list->string
   (apply string-append
          (map (lambda (c) (list-ref values (car (index-where key (lambda (k) (char=? k c))))))
               (string->list word)))))

(define (decrypt key values encrypted)
  (let loop ([chars (string->list encrypted)]
             [result '()]
             [index 0])
    (cond
      [(empty? chars)
       (list->string (reverse result))]
      [else
       (let ([pair (substring encrypted index (+ index 2))])
         (let ([idx (car (index-where values (lambda (v) (string=? v pair))))])
           (if (not (equal? idx #f))
               (loop (drop chars 2) (cons (list-ref key idx) result) (+ index 2))
               #f)))])))

(define (index-where lst pred?)
  (let loop ([lst lst]
             [idx 0])
    (cond
      [(empty? lst) (list #f)]
      [(pred? (car lst)) (list idx)]
      [else (loop (cdr lst) (+ idx 1))])))