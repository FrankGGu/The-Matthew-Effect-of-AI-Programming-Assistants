#lang racket

(require racket/hash)
(require racket/generic/queue)

(define MAX_COORD 1000000)
(define MAX_BLOCKED_COUNT 200)
(define MAX_SEARCH_AREA (* MAX_BLOCKED_COUNT MAX_BLOCKED_COUNT))

(define (is-escape-possible blocked source target)
  (define blocked-set (make-hash-set))
  (for-each (lambda (b) (hash-set-add! blocked-set (list (car b) (cadr b)))) blocked)

  (define (can-reach? start-pos end-pos escape-possible-return)
    (define q (make-queue))
    (queue-add! q start-pos)

    (define visited (make-hash-set))
    (hash-set-add! visited start-pos)

    (define count 0)
    (define directions (list (list 0 1) (list 0 -1) (list 1 0) (list -1 0)))

    (let loop ()
      (when (and (not (queue-empty? q)) (< count MAX_SEARCH_AREA))
        (define curr-pos (queue-remove! q))
        (define curr-r (car curr-pos))
        (define curr-c (cadr curr-pos))

        (when (equal? curr-pos end-pos)
          (escape-possible-return #t))

        (set! count (+ count 1))

        (for-each (lambda (dir)
                    (define dr (car dir))
                    (define dc (cadr dir))

                    (define next-r (+ curr-r dr))
                    (define next-c (+ curr-c dc))
                    (define next-pos (list next-r next-c))

                    (when (and (>= next-r 0) (< next-r MAX_COORD)
                               (>= next-c 0) (< next-c MAX_COORD)
                               (not (hash-set-has-key? blocked-set next-pos))
                               (not (hash-set-has-key? visited next-pos)))
                      (hash-set-add! visited next-pos)
                      (queue-add! q next-pos)))
                  directions)
        (loop)))

    (if (>= count MAX_SEARCH_AREA)
        #t
        #f))

  (call/cc (lambda (escape-possible-return)
             (and (can-reach? source target escape-possible-return)
                  (can-reach? target source escape-possible-return)))))