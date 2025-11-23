#lang racket

(define (randomized-collection)
  (define data (make-vector 200001))
  (define val-to-indices (make-hash))
  (define current-size 0)

  (define (insert val)
    (let ((val-was-not-present (not (hash-has-key? val-to-indices val))))

      (vector-set! data current-size val)

      (let ((indices (hash-ref val-to-indices val (lambda () (make-hash-set)))))
        (hash-set-add! indices current-size)
        (hash-set! val-to-indices val indices))

      (set! current-size (+ current-size 1))
      val-was-not-present))

  (define (remove val)
    (let ((indices (hash-ref val-to-indices val #f)))
      (unless indices #f)

      (let* ((idx-to-remove (hash-set-first indices)) 
             (last-idx (- current-size 1))
             (last-val (vector-ref data last-idx)))

        (hash-set-remove! indices idx-to-remove)
        (when (hash-set-empty? indices)
          (hash-remove! val-to-indices val))

        (unless (= idx-to-remove last-idx)
          (vector-set! data idx-to-remove last-val)

          (let ((last-val-indices (hash-ref val-to-indices last-val (lambda () (make-hash-set)))))
            (hash-set-remove! last-val-indices last-idx)
            (hash-set-add! last-val-indices idx-to-remove)))

        (set! current-size (- current-size 1))
        #t)))

  (define (get-random)
    (vector-ref data (random current-size)))

  (lambda (method . args)
    (case method
      ((insert) (apply insert args))
      ((remove) (apply remove args))
      ((getRandom) (apply get-random args))
      (else (error "unknown method")))))