#lang racket

(define (deserialize s)
  (define (parse-list tokens)
    (let loop ([tokens tokens] [acc '()])
      (cond
        [(null? tokens) (values (reverse acc) '())]
        [(equal? (car tokens) "]") (values (reverse acc) (cdr tokens))]
        [else
         (let-values ([(val rest) (parse-token tokens)])
           (loop rest (cons val acc))])))

  (define (parse-token tokens)
    (cond
      [(null? tokens) (values '() '())]
      [(equal? (car tokens) "[") 
       (let-values ([(lst rest) (parse-list (cdr tokens))])
         (values (list->vector lst) rest)]
      [(equal? (car tokens) "]") (values '() tokens)]
      [else (values (string->number (car tokens)) (cdr tokens))]))

  (define (tokenize s)
    (let loop ([s s] [acc '()] [current '()])
      (cond
        [(string=? s "") 
         (if (null? current) 
             (reverse acc) 
             (reverse (cons (list->string (reverse current)) acc)))]
        [(or (char=? (string-ref s 0) #\[) 
             (char=? (string-ref s 0) #\]))
         (loop (substring s 1)
               (if (null? current)
                   (cons (substring s 0 1) acc)
                   (cons (substring s 0 1) (cons (list->string (reverse current)) acc))
               '())]
        [(char=? (string-ref s 0) #\,)
         (loop (substring s 1)
               (if (null? current)
                   acc
                   (cons (list->string (reverse current)) acc))
               '())]
        [else
         (loop (substring s 1) acc (cons (string-ref s 0) current))])))

  (let ([tokens (tokenize s)])
    (if (null? tokens)
        (vector)
        (let-values ([(val _) (parse-token tokens)])
          val))))