#lang racket

(define (count-of-atoms form)
  (let loop ([lst (string->list form)]
             [stack (list (make-hash))]
             [i 0]
             [n (string-length form)])
    (if (= i n)
        (let ([counts (car stack)])
          (string-join
           (sort (hash-map counts (lambda (k v) (format "~a~a" k (if (= v 1) "" v))))
           ""))
        (let ([c (list-ref lst i)])
          (cond
            [(char-upper-case? c)
             (let-values ([(name j) (parse-name lst i n)])
               (let-values ([(num k) (parse-number lst j n)])
                 (loop lst
                       (cons (hash-update (car stack) name (lambda (v) (+ v num)) (lambda () 0))
                             (cdr stack))
                       k
                       n)))]
            [(char=? c #\( )
             (loop lst (cons (make-hash) stack) (add1 i) n)]
            [(char=? c #\) )
             (let-values ([(num j) (parse-number lst (add1 i) n)])
               (let ([top (car stack)]
                     [rest (cdr stack)])
                 (loop lst
                       (cons (foldl (lambda (k v h) (hash-update h k (lambda (old) (+ old (* v num))) (lambda () 0)))
                                   (car rest)
                                   (hash->list top))
                             (cdr rest))
                       j
                       n)))]
            [else (loop lst stack (add1 i) n)]))))

(define (parse-name lst i n)
  (let ([start i])
    (let loop ([i (add1 i)])
      (if (and (< i n) (char-lower-case? (list-ref lst i)))
          (loop (add1 i))
          (values (list->string (take (drop lst start) (- i start))) i)))))

(define (parse-number lst i n)
  (let loop ([i i]
             [num 0])
    (if (and (< i n) (char-numeric? (list-ref lst i)))
        (loop (add1 i) (+ (* num 10) (- (char->integer (list-ref lst i)) 48)))
        (values (if (= num 0) 1 num) i))))

(define (countOfAtoms formula)
  (count-of-atoms formula))