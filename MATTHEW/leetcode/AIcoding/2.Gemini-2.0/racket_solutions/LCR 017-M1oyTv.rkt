(define (min-window s t)
  (let* ((s-len (string-length s))
         (t-len (string-length t))
         (t-freq (make-hash))
         (window-freq (make-hash)))

    (for ((c (in-string t)))
      (hash-update! t-freq c (λ (x) (+ x 1)) 1))

    (let loop ((left 0)
               (right 0)
               (matched 0)
               (min-len (+ s-len 1))
               (start 0))

      (cond
        [(>= right s-len)
         (if (= min-len (+ s-len 1))
             ""
             (substring s start (+ start min-len)))]
        [else
         (let* ((c (string-ref s right)))
           (hash-update! window-freq c (λ (x) (+ x 1)) 1)
           (when (and (hash-has-key? t-freq c)
                      (= (hash-ref window-freq c) (hash-ref t-freq c)))
             (set! matched (+ matched 1)))

           (let shrink ((l left))
             (if (= matched t-len)
                 (let* ((left-char (string-ref s l)))
                   (if (and (hash-has-key? t-freq left-char)
                            (> (hash-ref window-freq left-char) (hash-ref t-freq left-char)))
                       (begin
                         (hash-update! window-freq left-char (λ (x) (- x 1)) 0)
                         (shrink (+ l 1)))
                       (if (hash-has-key? t-freq left-char)
                           (if (< (- right l 1) min-len)
                               (loop (+ l 1) (+ right 1) (- matched 1) (- right l 1) l)
                               (loop (+ l 1) (+ right 1) (- matched 1) min-len start))
                           (if (< (- right l 1) min-len)
                               (loop (+ l 1) (+ right 1) matched (- right l 1) l)
                               (loop (+ l 1) (+ right 1) matched min-len start))))
                 )
                 (loop left (+ right 1) matched min-len start))
             ))]))))