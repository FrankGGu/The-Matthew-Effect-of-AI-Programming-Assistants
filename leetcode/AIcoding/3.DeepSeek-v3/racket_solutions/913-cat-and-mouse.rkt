#lang racket

(define (cat-mouse-game graph)
  (define n (length graph))
  (define memo (make-hash))
  (define colors (make-hash))
  (define degree (make-hash))

  (for ([i (in-range n)])
    (hash-set! degree i (length (list-ref graph i))))

  (define (dp mouse cat turns)
    (define key (list mouse cat turns))
    (cond
      [(hash-has-key? memo key) (hash-ref memo key)]
      [(= cat mouse) 2]
      [(= mouse 0) 1]
      [(>= turns (* 2 n)) 0]
      [else
       (define res (if (zero? (modulo turns 2))
                       (let ([best 2])
                         (for ([next (in-list (list-ref graph mouse))])
                           (define cur (dp next cat (add1 turns)))
                           (when (< cur best)
                             (set! best cur))
                           (when (= best 1)
                             (break)))
                         best)
                       (let ([best 0])
                         (for ([next (in-list (list-ref graph cat))])
                           (when (not (= next 0))
                             (define cur (dp mouse next (add1 turns)))
                             (when (> cur best)
                               (set! best cur))
                             (when (= best 2)
                               (break))))
                         best)))
       (hash-set! memo key res)
       res]))

  (dp 1 2 0))