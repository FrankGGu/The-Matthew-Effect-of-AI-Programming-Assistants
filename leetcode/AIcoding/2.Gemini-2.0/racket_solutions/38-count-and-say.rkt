(define (count-and-say n)
  (define (helper s count char)
    (if (null? s)
        (list count char)
        (if (equal? (car s) char)
            (helper (cdr s) (+ count 1) char)
            (cons count (cons char (helper s 1 (car s)))))))

  (define (say s)
    (let loop ([lst (helper (string->list s) 0 #f)] [res '()])
      (if (null? lst)
          (list->string (reverse res))
          (loop (cddr lst) (cons (number->string (car lst)) (cons (list->string (list (cadr lst))) res)))))
    )

  (let loop ([i 1] [s "1"])
    (if (= i n)
        s
        (loop (+ i 1) (say s)))))