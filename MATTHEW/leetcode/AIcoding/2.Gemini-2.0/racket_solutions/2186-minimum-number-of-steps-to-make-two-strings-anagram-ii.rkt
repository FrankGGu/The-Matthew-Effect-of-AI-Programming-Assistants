(define (min-steps s t)
  (let* ((s-freq (make-hash))
         (t-freq (make-hash))
         (s-len (string-length s))
         (t-len (string-length t)))

    (for ((i s-len))
      (let ((char (string-ref s i)))
        (hash-update! s-freq char (lambda (v) (+ v 1)) 1)))

    (for ((i t-len))
      (let ((char (string-ref t i)))
        (hash-update! t-freq char (lambda (v) (+ v 1)) 1)))

    (let loop ((keys (append (hash-keys s-freq) (hash-keys t-freq)))
               (steps 0))
      (cond
        ((null? keys) steps)
        (else
         (let* ((key (car keys))
                (s-count (hash-ref s-freq key 0))
                (t-count (hash-ref t-freq key 0))
                (diff (abs (- s-count t-count))))
           (loop (cdr keys) (+ steps diff))))))))