#lang racket

(define-type NestedInteger
  (or/c number? (list/c NestedInteger)))

(define (deserialize s)
  (define (parse-integer str)
    (string->number str))

  (define (parse-nested str)
    (cond
      [(string=? str "") '()]
      [(char=? (string-ref str 0) #\[]) (parse-list str)]
      [else (parse-int str)]))

  (define (parse-list str)
    (let loop [(start 1) (current 1) (result '())]
      (if (< start (string-length str))
          (let* ([char (string-ref str start)])
            (cond
              [(char=? char #\[)
               (define inner (loop (+ start 1) (+ current 1) result))
               (loop (car inner) (cdr inner) (cons (car (cdr inner)) result))]
              [(char=? char #\])
               (values (add1 start) (reverse result))]
              [(char=? char #\,)
               (loop (+ start 1) current result)]
              [else
               (let ([number (parse-integer (string-take str (add1 start)))])
                 (loop (+ start (string-length (number->string number))) current (cons number result)))])))
          (values start result)))

  (define (parse str)
    (if (string=? str "")
        '()
        (parse-nested str)))

  (define result (parse (substring s 1 (sub1 (string-length s)))))
  (if (and (list? result) (empty? result))
      '()
      (if (null? result)
          '()
          (list->NestedInteger result)))))

(define (list->NestedInteger lst)
  (if (null? lst)
      '()
      (cons (if (number? (car lst))
                (car lst)
                (list->NestedInteger (car lst)))
            (list->NestedInteger (cdr lst)))))

(define (deserialize s)
  (list->NestedInteger (parse (substring s 1 (sub1 (string-length s))))))