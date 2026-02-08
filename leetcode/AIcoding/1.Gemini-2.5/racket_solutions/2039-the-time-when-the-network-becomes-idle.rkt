(require racket/queue)

(define (the-time-when-the-network-becomes-idle edges patience)
  (define n (vector-length patience))

  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define dist (make-vector n -1))
  (define q (make-queue))

  (vector-set! dist 0 0)
  (queue-push! q 0)

  (let loop ()
    (when (not (queue-empty? q))
      (define u (queue-pop! q))
      (define d_u (vector-ref dist u))

      (for-each (lambda (v)
                  (when (= (vector-ref dist v) -1)
                    (vector-set! dist v (+ d_u 1))
                    (queue-push! q v)))
                (vector-ref adj u))
      (loop)))

  (define max-idle-time 0)

  (for i (in-range 1 n)
    (define d_i (vector-ref dist i))
    (define p_i (vector-ref patience i))

    (define round-trip-time (* 2 d_i))

    (define idle-time-i 0)
    (if (<= round-trip-time p_i)
        (set! idle-time-i round-trip-time)
        (begin
          (define num-extra-sends (quotient (- round-trip-time 1) p_i))
          (define t-last-send (* num-extra-sends p_i))
          (set! idle-time-i (+ t-last-send round-trip-time))))

    (set! max-idle-time (max max-idle-time idle-time-i)))

  max-idle-time)