#lang racket

(define (can-mouse-win grid cat-mouse jump)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))

  (define (get-pos c)
    (for/first ([i (in-range m)]
                [row (in-list grid)]
                [j (in-range n)]
                #:when (char=? (string-ref (list-ref grid i) j) c))
      (cons i j)))

  (define mouse-pos (get-pos #\M))
  (define cat-pos (get-pos #\C))
  (define food-pos (get-pos #\F))

  (define dirs '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))

  (define memo (make-hash))

  (define (dp t mouse cat)
    (define key (list t mouse cat))
    (hash-ref memo key
              (lambda ()
                (cond
                  [(or (>= t (* 2 m n))
                       (equal? cat food-pos)
                       (equal? mouse cat)]
                  [(equal? mouse food-pos) #t]
                  [(equal? cat food-pos) #f]
                  [else
                   (define mouse-moves
                     (cons mouse
                           (for/list ([d (in-list dirs)]
                                      #:when (let* ((ni (+ (car mouse) (car d)))
                                               (nj (+ (cdr mouse) (cdr d)))
                                               (and (>= ni 0) (< ni m)
                                                    (>= nj 0) (< nj n)
                                                    (not (char=? (string-ref (list-ref grid ni) nj) #\#)))))
                             (cons (+ (car mouse) (car d)) (+ (cdr mouse) (cdr d)))))
                   (define cat-moves
                     (cons cat
                           (for/list ([d (in-list dirs)]
                                      #:when (let* ((ni (+ (car cat) (car d)))
                                               (nj (+ (cdr cat) (cdr d)))
                                               (and (>= ni 0) (< ni m)
                                                    (>= nj 0) (< nj n)
                                                    (not (char=? (string-ref (list-ref grid ni) nj) #\#)))))
                             (cons (+ (car cat) (car d)) (+ (cdr cat) (cdr d)))))
                   (if (zero? (modulo t 2))
                       (ormap (lambda (next-mouse)
                                (not (dp (add1 t) next-mouse cat)))
                              mouse-moves)
                       (andmap (lambda (next-cat)
                                 (dp (add1 t) mouse next-cat))
                               cat-moves))]))))

  (dp 0 mouse-pos cat-pos))