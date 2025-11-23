#lang racket

(define (minimum-obstacle-removal grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define visited (make-hash))
  (define pq (priority-queue '()))
  (priority-queue-add! pq (cons 0 (cons 0 0)) <)
  (hash-set! visited (cons 0 0) #t)
  (define directions '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))
  (let loop ()
    (when (not (priority-queue-empty? pq))
      (define current (priority-queue-remove! pq))
      (define cost (car current))
      (define x (caadr current))
      (define y (cdadr current))
      (cond [(and (= x (sub1 rows)) (= y (sub1 cols))) cost]
            [else
             (for-each
              (lambda (d)
                (define nx (+ x (car d)))
                (define ny (+ y (cdr d)))
                (when (and (<= 0 nx (sub1 rows)) (<= 0 ny (sub1 cols)))
                  (define new-cost (+ cost (if (= (list-ref (list-ref grid nx) ny) 1) 1 0)))
                  (define key (cons nx ny))
                  (when (not (hash-has-key? visited key))
                    (hash-set! visited key #t)
                    (priority-queue-add! pq (cons new-cost (cons nx ny)) <))))
              directions)
             (loop)])))

(minimum-obstacle-removal grid)