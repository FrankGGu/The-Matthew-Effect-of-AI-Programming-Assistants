#lang racket

(define (length-of-longest-file-path s)
  (define (helper s)
    (let loop ([s s] [dir-map '()] [max-length 0])
      (cond [(string=? s "") max-length]
            [else
             (let* ([lines (string-split s "\n")]
                    [line (car lines)]
                    [rest (string-join (cdr lines) "\n")])
               (let ([depth (count (λ (c) (char=? c #\t)) line)])
                 (let ([name (substring line depth)])
                   (if (string-contains? name ".")
                       (loop rest dir-map (max max-length (+ (length name) (list-ref dir-map depth))))
                       (loop rest (cons (add1 (length name)) dir-map) max-length)))))])))
  (helper s))

(define (string-contains? s substr)
  (not (equal? (string-index s substr) #f)))

(define (count pred lst)
  (foldl (λ (x acc) (if (pred x) (add1 acc) acc)) 0 lst))