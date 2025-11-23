(define (reverse-vowels s)
  (let* ((char-vec (list->vector (string->list s)))
         (len (vector-length char-vec)))

    (define (is-vowel? c)
      (member c '(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U)))

    (define (loop left right)
      (cond
        ((>= left right) (void))
        (else
         (let ((left-char (vector-ref char-vec left))
               (right-char (vector-ref char-vec right)))
           (cond
             ((and (is-vowel? left-char) (is-vowel? right-char))
              (vector-set! char-vec left right-char)
              (vector-set! char-vec right left-char)
              (loop (+ left 1) (- right 1)))
             ((is-vowel? left-char)
              (loop left (- right 1)))
             ((is-vowel? right-char)
              (loop (+ left 1) right))
             (else
              (loop (+ left 1) (- right 1))))))))

    (loop 0 (- len 1))
    (list->string (vector->list char-vec))))