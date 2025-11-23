(define-struct peeking-iterator (base-iter peeked-val has-peeked-val?))

(define (PeekingIterator iterator)
  (make-peeking-iterator iterator #f #f))

(define (peeking-iterator-peek pi)
  (unless (peeking-iterator-has-peeked-val? pi)
    (set-peeking-iterator-peeked-val! pi ((iterator-next (peeking-iterator-base-iter pi))))
    (set-peeking-iterator-has-peeked-val?! pi #t))
  (peeking-iterator-peeked-val pi))

(define (peeking-iterator-next pi)
  (if (peeking-iterator-has-peeked-val? pi)
      (let ((val (peeking-iterator-peeked-val pi)))
        (set-peeking-iterator-has-peeked-val?! pi #f)
        val)
      ((iterator-next (peeking-iterator-base-iter pi)))))

(define (peeking-iterator-has-next pi)
  (or (peeking-iterator-has-peeked-val? pi)
      ((iterator-has-next (peeking-iterator-base-iter pi)))))