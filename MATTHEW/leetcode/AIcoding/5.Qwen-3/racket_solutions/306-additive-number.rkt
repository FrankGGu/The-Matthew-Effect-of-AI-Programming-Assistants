#lang racket

(define (additive-number num)
  (define (is-additive a b rest)
    (if (null? rest)
        #t
        (let ((sum (+ a b)))
          (and (string=? (number->string sum) (car rest))
               (is-additive b sum (cdr rest))))))

  (define (parse-num s)
    (map string->number (string-split s "")))

  (define (helper s)
    (let loop ((i 1))
      (when (> i (- (string-length s) 2))
        #f)
      (let ((a (string->number (substring s 0 i))))
        (loop (+ i 1))
        (let ((j (max i 1)))
          (loop (+ j 1))
          (let ((b (string->number (substring s i j))))
            (let ((rest (substring s j)))
              (if (is-additive a b (parse-num rest))
                  #t
                  (loop (+ j 1)))))))))

  (if (>= (string-length num) 3)
      (helper num)
      #f))