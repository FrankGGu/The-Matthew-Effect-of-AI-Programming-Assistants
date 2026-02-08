(define (longest-valid-substring word forbidden)
  (define forbidden-set (list->set forbidden))
  (define n (string-length word))
  (define max-len 0)
  (define left 0)

  (for ([right (in-range n)])
    (define current-char (string-ref word right))
    (define substring (substring word left (+ right 1)))
    (define len (+ (- right left) 1))

    (when (set-member? forbidden-set substring)
      (set! left (+ right 1)))

    (set! max-len (max max-len (- right left -1))))

  max-len)