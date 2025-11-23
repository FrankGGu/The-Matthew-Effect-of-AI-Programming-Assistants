(define (is-one-bit-character bits)
  (define (helper idx)
    (if (>= idx (sub1 (length bits)))
        #t
        (if (= (list-ref bits idx) 1)
            (helper (+ idx 2))
            (helper (+ idx 1)))))
  (helper 0))

(define (isOneBitCharacter bits)
  (is-one-bit-character bits))