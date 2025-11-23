#lang racket

(require racket/queue)
(require racket/hash)

(define (color-border grid r0 c0 color)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define initial-color (list-ref (list-ref grid r0) c0))

  (define q (make-queue))
  (define visited (make-hash))
  (define border-cells (make-hash))

  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (hash-set! visited (cons r0 c0) #t)
  (queue-add! q (cons r0 c0))

  (let process-queue ()
    (unless (queue-empty? q)
      (define current-cell (queue-remove! q))
      (define current-r (car current-cell))
      (define current-c (cdr current-cell))

      (define is-current-cell-border #f)

      (when (or (= current-r 0) (= current-r (- rows 1))
                (= current-c 0) (= current-c (- cols 1)))
        (set! is-current-cell-border #t))

      (for ([i (range 4)])
        (define nr (+ current-r (list-ref dr i)))
        (define nc (+ current-c (list-ref dc i)))

        (cond
          [(or (not (valid? nr nc))
               (not (= (list-ref (list-ref grid nr) nc) initial-color)))
           (set! is-current-cell-border #t)]
          [else
           (unless (hash-has-key? visited (cons nr nc))
             (hash-set! visited (cons nr nc) #t)
             (queue-add! q (cons nr nc)))]))

      (when is-current-cell-border
        (hash-set! border-cells (cons current-r current-c) #t))

      (process-queue)))

  (build-list rows
              (lambda (r)
                (build-list cols
                            (lambda (c)
                              (if (hash-has-key? border-cells (cons r c))
                                  color
                                  (list-ref (list-ref grid r) c)))))))