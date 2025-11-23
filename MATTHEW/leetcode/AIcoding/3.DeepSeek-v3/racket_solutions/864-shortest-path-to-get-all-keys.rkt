#lang racket

(define (shortest-path-all-keys grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (string-length (first grid))))
  (define dirs '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))

  (define (bfs)
    (define q (make-queue))
    (define visited (make-hash))
    (define all-keys 0)
    (define start-x 0)
    (define start-y 0)

    (for* ([i (in-range m)] [j (in-range n)])
      (define c (string-ref (list-ref grid i) j))
      (cond
        [(char-lower-case? c)
         (set! all-keys (bitwise-ior all-keys (arithmetic-shift 1 (- (char->integer c) (char->integer #\a)))))]
        [(char=? c #\@)
         (set! start-x i)
         (set! start-y j)]))

    (hash-set! visited (cons start-x (cons start-y 0)) #t)
    (enqueue! q (list start-x start-y 0 0))

    (let loop ()
      (if (queue-empty? q)
          -1
          (let ([curr (dequeue! q)])
            (define x (first curr))
            (define y (second curr))
            (define keys (third curr))
            (define steps (fourth curr))

            (if (= keys all-keys)
                steps
                (begin
                  (for ([dir dirs])
                    (define nx (+ x (car dir)))
                    (define ny (+ y (cdr dir)))
                    (when (and (>= nx 0) (< nx m) (>= ny 0) (< ny n))
                      (define nc (string-ref (list-ref grid nx) ny))
                      (cond
                        [(char=? nc #\#) (void)]
                        [(char-upper-case? nc)
                         (define needed-key (arithmetic-shift 1 (- (char->integer nc) (char->integer #\A))))
                         (when (bitwise-bit-set? keys needed-key)
                           (define new-keys keys)
                           (define state (cons nx (cons ny new-keys)))
                           (unless (hash-has-key? visited state)
                             (hash-set! visited state #t)
                             (enqueue! q (list nx ny new-keys (add1 steps)))))]
                        [(char-lower-case? nc)
                         (define new-keys (bitwise-ior keys (arithmetic-shift 1 (- (char->integer nc) (char->integer #\a)))))
                         (define state (cons nx (cons ny new-keys)))
                         (unless (hash-has-key? visited state)
                           (hash-set! visited state #t)
                           (enqueue! q (list nx ny new-keys (add1 steps))))]
                        [else
                         (define state (cons nx (cons ny keys)))
                         (unless (hash-has-key? visited state)
                           (hash-set! visited state #t)
                           (enqueue! q (list nx ny keys (add1 steps))))]))
                  (loop)))))))

  (bfs))

(define (make-queue) (mcons null null))
(define (queue-empty? q) (null? (mcar q)))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (list x)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr q) (list x)) (set-mcdr! q (mcdr (mcdr q))))))
(define (dequeue! q)
  (define front (mcar q))
  (set-mcar! q (cdr front))
  (when (null? (mcar q)) (set-mcdr! q null))
  (car front))