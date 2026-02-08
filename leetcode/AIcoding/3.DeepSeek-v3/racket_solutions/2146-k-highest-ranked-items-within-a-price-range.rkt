#lang racket

(define (highest-ranked-items grid pricing start k)
  (let* ([m (vector-length grid)]
         [n (vector-length (vector-ref grid 0))]
         [visited (make-vector m (make-vector n #f))]
         [result '()]
         [q (queue)]
         [directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0))])
    (enqueue! q (cons (car start) (cdr start)))
    (vector-set! (vector-ref visited (car start)) (cdr start) #t)
    (let loop ([distance 0])
      (unless (queue-empty? q)
        (let ([size (queue-length q)]
              [current-level '()])
          (for ([i (in-range size)])
            (let* ([pos (dequeue! q)]
                   [x (car pos)]
                   [y (cdr pos)]
                   [price (vector-ref (vector-ref grid x) y)])
              (when (and (>= price (car pricing)) (<= price (cdr pricing)))
                (set! current-level (cons (list distance price x y) current-level)))
              (for ([dir directions])
                (let ([nx (+ x (car dir))]
                      [ny (+ y (cdr dir))])
                  (when (and (>= nx 0) (< nx m) (>= ny 0) (< ny n)
                           (not (vector-ref (vector-ref visited nx) ny))
                           (not (zero? (vector-ref (vector-ref grid nx) ny))))
                    (vector-set! (vector-ref visited nx) ny #t)
                    (enqueue! q (cons nx ny)))))))
          (set! current-level (sort current-level (lambda (a b)
                                                   (let ([d1 (car a)] [p1 (cadr a)] [x1 (caddr a)] [y1 (cadddr a)]
                                                         [d2 (car b)] [p2 (cadr b)] [x2 (caddr b)] [y2 (cadddr b)])
                                                     (cond
                                                       [(not (= d1 d2)) (< d1 d2)]
                                                       [(not (= p1 p2)) (< p1 p2)]
                                                       [(not (= x1 x2)) (< x1 x2)]
                                                       [else (< y1 y2)])))))
          (set! result (append result current-level))
          (loop (add1 distance)))))
    (take (map (lambda (x) (list (caddr x) (cadddr x))) result) (min k (length result))))

(define (queue)
  (let ([front '()]
        [rear '()])
    (define (empty?)
      (and (null? front) (null? rear)))
    (define (enqueue! x)
      (set! rear (cons x rear)))
    (define (dequeue!)
      (if (null? front)
          (begin
            (set! front (reverse rear))
            (set! rear '())
            (if (null? front)
                (error "dequeue! empty queue")
                (let ([x (car front)])
                  (set! front (cdr front))
                  x)))
          (let ([x (car front)])
            (set! front (cdr front))
            x)))
    (define (length)
      (+ (length front) (length rear)))
    (lambda (msg)
      (case msg
        ['empty? empty?]
        ['enqueue! enqueue!]
        ['dequeue! dequeue!]
        ['length length]))))

(define (enqueue! q x) ((q 'enqueue!) x))
(define (dequeue! q) ((q 'dequeue!)))
(define (queue-empty? q) ((q 'empty?)))
(define (queue-length q) ((q 'length)))