#lang racket

(define (shortest-pan-to-get-all-keys grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))
  (define keys #f)
  (define start #f)
  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define cell (list-ref (list-ref grid i) j))
      (cond [(char=? cell #\@) (set! start (cons i j))]
            [(char=? cell #\.) #f]
            [(char=? cell #\#) #f]
            [else (set! keys (cons cell keys))])))
  (define key-count (length keys))
  (define target-mask (for/fold ([mask 0]) ([k keys]) (bitwise-ior mask (arithmetic-shift 1 (- (char->integer k) (char->integer #\a))))))

  (define visited (make-hash))
  (define (get-key-mask x y)
    (for/fold ([mask 0]) ([k keys])
      (if (char=? (list-ref (list-ref grid x) y) k)
          (bitwise-ior mask (arithmetic-shift 1 (- (char->integer k) (char->integer #\a))))
          mask)))

  (define (bfs)
    (define queue (queue (cons (append start (list 0 0))))) ; (x y mask steps)
    (hash-set! visited (append start (list 0)) #t)
    (let loop ()
      (when (not (queue-empty? queue))
        (define current (queue-dequeue! queue))
        (define x (car current))
        (define y (cadr current))
        (define mask (caddr current))
        (define steps (cadddr current))
        (when (= mask target-mask) steps)
        (for-each
         (lambda (d)
           (define nx (+ x (car d)))
           (define ny (+ y (cdr d)))
           (when (and (<= 0 nx (sub1 rows)) (<= 0 ny (sub1 cols)))
             (define cell (list-ref (list-ref grid nx) ny))
             (cond [(char=? cell #\#) #f]
                   [(char=? cell #\.) 
                    (define new-mask mask)
                    (define state (list nx ny new-mask))
                    (when (not (hash-has-key? visited state))
                      (hash-set! visited state #t)
                      (queue-enqueue! queue (list nx ny new-mask (+ steps 1))))]
                   [(char=? cell #\@) 
                    (define new-mask mask)
                    (define state (list nx ny new-mask))
                    (when (not (hash-has-key? visited state))
                      (hash-set! visited state #t)
                      (queue-enqueue! queue (list nx ny new-mask (+ steps 1))))]
                   [else
                    (define key-char cell)
                    (define key-index (- (char->integer key-char) (char->integer #\a)))
                    (define new-mask (bitwise-ior mask (arithmetic-shift 1 key-index)))
                    (define state (list nx ny new-mask))
                    (when (not (hash-has-key? visited state))
                      (hash-set! visited state #t)
                      (queue-enqueue! queue (list nx ny new-mask (+ steps 1))))]))
         directions))
        (loop))))

  (if (or (not start) (zero? key-count)) 0 (bfs)))