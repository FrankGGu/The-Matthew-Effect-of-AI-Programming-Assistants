#lang racket

(define-struct Solution (N blacklist-set mapping effective-size))

(define (Solution-init N blacklist)
  (define blacklist-set (make-hasheq))
  (for-each (lambda (b) (hash-set! blacklist-set b #t)) blacklist)

  (define effective-size (- N (length blacklist)))
  (define mapping (make-hasheq))

  (define current-candidate (- N 1))

  (for-each (lambda (b)
              (when (< b effective-size)
                (let find-candidate ()
                  (when (hash-has-key? blacklist-set current-candidate)
                    (set! current-candidate (- current-candidate 1))
                    (find-candidate)))
                (hash-set! mapping b current-candidate)
                (set! current-candidate (- current-candidate 1))))
            blacklist)

  (Solution N blacklist-set mapping effective-size))

(define (Solution-pick this)
  (define r (random (Solution-effective-size this)))
  (if (hash-has-key? (Solution-mapping this) r)
      (hash-ref (Solution-mapping this) r)
      r))