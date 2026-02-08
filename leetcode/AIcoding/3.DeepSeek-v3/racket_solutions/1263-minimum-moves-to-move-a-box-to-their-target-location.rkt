#lang racket

(define (min-push-box grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (string-length (car grid))))
  (define dirs '((0 1) (1 0) (0 -1) (-1 0)))

  (define (valid? x y)
    (and (>= x 0) (< x m) (>= y 0) (< y n) (not (char=? (string-ref (list-ref grid x) y) #\#)))

  (define (find-pos c)
    (for*/first ([i (in-range m)]
                 [j (in-range n)]
                 #:when (char=? (string-ref (list-ref grid i) j) c))
      (cons i j)))

  (define box (find-pos #\B))
  (define target (find-pos #\T))
  (define player (find-pos #\S))

  (define visited (make-hash))
  (define q (make-queue))
  (enqueue! q (list (car box) (cdr box) (car player) (cdr player) 0))
  (hash-set! visited (list (car box) (cdr box) (car player) (cdr player)) #t)

  (let loop ()
    (if (queue-empty? q)
        -1
        (let* ([current (dequeue! q)]
               [bx (first current)]
               [by (second current)]
               [px (third current)]
               [py (fourth current)]
               [moves (fifth current)])
          (if (and (= bx (car target)) (= by (cdr target)))
              moves
              (begin
                (for ([d dirs])
                  (let* ([dx (first d)]
                         [dy (second d)]
                         [new-px (+ px dx)]
                         [new-py (+ py dy)])
                    (when (valid? new-px new-py)
                      (if (and (= new-px bx) (= new-py by))
                          (let* ([new-bx (+ bx dx)]
                                 [new-by (+ by dy)]
                                 [new-moves (add1 moves)])
                            (when (valid? new-bx new-by)
                              (unless (hash-has-key? visited (list new-bx new-by new-px new-py))
                                (hash-set! visited (list new-bx new-by new-px new-py) #t)
                                (enqueue! q (list new-bx new-by new-px new-py new-moves))))
                          (unless (hash-has-key? visited (list bx by new-px new-py))
                            (hash-set! visited (list bx by new-px new-py) #t)
                            (enqueue! q (list bx by new-px new-py moves)))))))
                (loop)))))))