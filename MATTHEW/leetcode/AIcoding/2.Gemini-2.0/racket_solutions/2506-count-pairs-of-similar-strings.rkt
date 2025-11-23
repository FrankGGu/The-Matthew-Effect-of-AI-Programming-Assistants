(define (similar-strings? s1 s2)
  (equal? (list->set (string->list s1)) (list->set (string->list s2))))

(define (count-similar-pairs words)
  (let loop ([words words] [count 0])
    (cond
      [(null? words) count]
      [else
       (let ([first-word (car words)]
             [rest-words (cdr words)])
         (loop rest-words
               (+ count
                  (length (filter (lambda (word) (similar-strings? first-word word)) rest-words)))))])))