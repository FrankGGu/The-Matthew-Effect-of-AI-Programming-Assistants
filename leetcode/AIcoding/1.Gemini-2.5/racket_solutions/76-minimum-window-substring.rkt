(define (min-window s t)
  (define s-len (string-length s))
  (define t-len (string-length t))

  (when (zero? t-len)
    (string ""))

  (define target-freq (make-hash))
  (for ([char (in-string t)])
    (hash-set! target-freq char (add1 (hash-ref target-freq char 0))))

  (define window-freq (make-hash))
  (define left 0)
  (define matched-chars 0)
  (define min-len +inf.0)
  (define start-idx -1)

  (for ([right (in-range s-len)])
    (define char-r (string-ref s right))

    (when (hash-has-key? target-freq char-r)
      (define current-count (hash-ref window-freq char-r 0))
      (define target-count (hash-ref target-freq char-r))
      (hash-set! window-freq char-r (add1 current-count))
      (when (< current-count target-count)
        (set! matched-chars (add1 matched-chars))))

    (let loop ()
      (when (= matched-chars t-len)
        (define current-window-len (add1 (- right left)))
        (when (< current-window-len min-len)
          (set! min-len current-window-len)
          (set! start-idx left))

        (define char-l (string-ref s left))

        (when (hash-has-key? target-freq char-l)
          (define current-count (hash-ref window-freq char-l))
          (define target-count (hash-ref target-freq char-l))
          (hash-set! window-freq char-l (sub1 current-count))
          (when (<= current-count target-count)
            (set! matched-chars (sub1 matched-chars))))
        (set! left (add1 left))
        (loop))))

  (if (= start-idx -1)
      (string "")
      (substring s start-idx (+ start-idx min-len))))