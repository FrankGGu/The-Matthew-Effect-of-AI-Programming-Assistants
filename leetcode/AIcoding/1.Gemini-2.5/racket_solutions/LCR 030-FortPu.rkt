#lang racket

(require racket/hash)
(require racket/vector)
(require racket/random)

(struct randomized-set (vals val-to-idx current-size) #:mutable)

(define (randomized-set-init-internal)
  (randomized-set (make-vector 16) (make-hash) 0))

(define (randomized-set-insert-internal rs val)
  (let ((val-to-idx (randomized-set-val-to-idx rs))
        (vals (randomized-set-vals rs))
        (current-size (randomized-set-current-size rs)))
    (if (hash-has-key? val-to-idx val)
        #f
        (begin
          (when (= current-size (vector-length vals))
            (let* ((new-capacity (* 2 (vector-length vals)))
                   (new-vals (make-vector new-capacity)))
              (for ([i (in-range current-size)])
                (vector-set! new-vals i (vector-ref vals i)))
              (set-randomized-set-vals! rs new-vals)))
          (hash-set! val-to-idx val current-size)
          (vector-set! (randomized-set-vals rs) current-size val)
          (set-randomized-set-current-size! rs (+ current-size 1))
          #t))))

(define (randomized-set-remove-internal rs val)
  (let ((val-to-idx (randomized-set-val-to-idx rs))
        (vals (randomized-set-vals rs))
        (current-size (randomized-set-current-size rs)))
    (if (not (hash-has-key? val-to-idx val))
        #f
        (begin
          (let* ((idx-to-remove (hash-ref val-to-idx val))
                 (last-val (vector-ref vals (- current-size 1))))
            (vector-set! vals idx-to-remove last-val)
            (hash-set! val-to-idx last-val idx-to-remove)
            (hash-remove! val-to-idx val)
            (set-randomized-set-current-size! rs (- current-size 1)))
          #t))))

(define (randomized-set-get-random-internal rs)
  (let ((vals (randomized-set-vals rs))
        (current-size (randomized-set-current-size rs)))
    (let ((rand-idx (random current-size)))
      (vector-ref vals rand-idx))))

(define (RandomizedSet)
  (let ((rs (randomized-set-init-internal)))
    (lambda (method . args)
      (case method
        ((insert) (randomized-set-insert-internal rs (car args)))
        ((remove) (randomized-set-remove-internal rs (car args)))
        ((getRandom) (randomized-set-get-random-internal rs))
        (else (error "Unknown method" method))))))