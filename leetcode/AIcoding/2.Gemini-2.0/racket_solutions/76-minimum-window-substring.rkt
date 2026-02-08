(define (min-window s t)
  (let* ((s-len (string-length s))
         (t-len (string-length t))
         (t-freq (make-hash))
         (window-freq (make-hash)))

    (for ((i t-len))
      (let ((char (string-ref t i)))
        (hash-update! t-freq char (λ (v) (+ v 1)) 1)))

    (define (valid?)
      (hash-for-each t-freq
                     (λ (char count)
                       (unless (and (hash-has-key? window-freq char)
                                    (>= (hash-ref window-freq char) count))
                         (return #f))))
      #t)

    (let loop ((left 0)
               (right 0)
               (min-len (+ s-len 1))
               (start 0))
      (cond
        ((>= right s-len)
         (if (= min-len (+ s-len 1))
             ""
             (substring s start (+ start min-len))))
        (else
         (let ((char (string-ref s right)))
           (hash-update! window-freq char (λ (v) (+ v 1)) 1)

           (if (valid?)
               (let loop2 ((left left))
                 (if (> left right)
                     (loop (+ right 1) (+ right 1) min-len start)
                     (let ((left-char (string-ref s left)))
                       (if (hash-has-key? t-freq left-char)
                           (let ((left-char-count (hash-ref window-freq left-char)))
                             (if (> left-char-count (hash-ref t-freq left-char))
                                 (begin
                                   (hash-update! window-freq left-char (λ (v) (- v 1)) 0)
                                   (loop2 (+ left 1)))
                                 (let ((current-len (- right left -1)))
                                   (if (< current-len min-len)
                                       (loop (+ right 1) (+ right 1) current-len left)
                                       (loop (+ right 1) (+ right 1) min-len start))))
                             )
                           (begin
                             (hash-update! window-freq left-char (λ (v) (- v 1)) 0)
                             (loop2 (+ left 1))))))
                 )
               (loop left (+ right 1) min-len start))))))))