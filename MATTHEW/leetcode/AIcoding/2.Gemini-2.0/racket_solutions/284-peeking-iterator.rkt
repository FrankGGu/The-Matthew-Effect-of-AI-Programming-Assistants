(provide (struct-out peeking-iterator)
         (make-peeking-iterator))

(struct peeking-iterator (it peeked has-peeked) #:mutable)

(define (make-peeking-iterator iterator)
  (peeking-iterator iterator #f #f))

(define (peek this)
  (cond
    [(peeking-iterator-has-peeked this) (peeking-iterator-peeked this)]
    [(iterator-hasNext (peeking-iterator-it this))
     (let ((next (iterator-next (peeking-iterator-it this))))
       (set-peeking-iterator-peeked! this next)
       (set-peeking-iterator-has-peeked! this #t)
       next)]
    [else #f]))

(define (next this)
  (cond
    [(peeking-iterator-has-peeked this)
     (let ((val (peeking-iterator-peeked this)))
       (set-peeking-iterator-peeked! this #f)
       (set-peeking-iterator-has-peeked! this #f)
       val)]
    [(iterator-hasNext (peeking-iterator-it this))
     (iterator-next (peeking-iterator-it this))]
    [else #f]))

(define (hasNext this)
  (or (peeking-iterator-has-peeked this)
      (iterator-hasNext (peeking-iterator-it this))))