#lang racket

(define (canMouseWin grid catJump mouseJump)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))

  (define (get-pos c)
    (for*/first ([i (in-range m)]
                 [j (in-range n)]
                 #:when (char=? (list-ref (list-ref grid i) j) c))
      (cons i j)))

  (define cat-start (get-pos 'C))
  (define mouse-start (get-pos 'M))
  (define food (get-pos 'F))

  (define (valid? i j)
    (and (>= i 0) (< i m) (>= j 0) (< j n) (not (char=? (list-ref (list-ref grid i) j) '#'))))

  (define memo (make-hash))

  (define (dfs turn mouse cat)
    (define key (list turn mouse cat))
    (hash-ref! memo key
               (lambda ()
                 (cond
                   [(equal? mouse food) #t]
                   [(equal? cat food) #f]
                   [(equal? mouse cat) #f]
                   [(= turn 100) #f]
                   [else
                    (if (zero? (modulo turn 2))
                        (mouse-move turn mouse cat)
                        (cat-move turn mouse cat))]))))

  (define (mouse-move turn mouse cat)
    (define i (car mouse))
    (define j (cdr mouse))
    (for/or ([d (in-list '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))])
      (let loop ([k 0] [ni i] [nj j])
        (if (> k mouseJump)
            #f
            (let ([ni (+ ni (car d))]
                  [nj (+ nj (cdr d))])
              (if (valid? ni nj)
                  (or (dfs (add1 turn) (cons ni nj) cat)
                  (loop (add1 k) ni nj)))))))

  (define (cat-move turn mouse cat)
    (define i (car cat))
    (define j (cdr cat))
    (for/and ([d (in-list '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))])
      (let loop ([k 0] [ni i] [nj j])
        (if (> k catJump)
            #t
            (let ([ni (+ ni (car d))]
                  [nj (+ nj (cdr d))])
              (if (valid? ni nj)
                  (and (dfs (add1 turn) mouse (cons ni nj))
                  (loop (add1 k) ni nj)))))))

  (dfs 0 mouse-start cat-start))