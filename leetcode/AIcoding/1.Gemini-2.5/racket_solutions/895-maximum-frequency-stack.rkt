(define-struct (FreqStack-internal #:mutable)
  (freq-map
   freq-stacks
   max-freq))

(define (FreqStack)
  (struct:FreqStack-internal (make-hash) (make-hash) 0))

(define (push this val)
  (let* ([current-freq-map (FreqStack-internal-freq-map this)]
         [current-freq-stacks (FreqStack-internal-freq-stacks this)]
         [old-freq (hash-ref current-freq-map val 0)]
         [new-freq (add1 old-freq)])

    (hash-set! current-freq-map val new-freq)

    (when (> new-freq (FreqStack-internal-max-freq this))
      (set-FreqStack-internal-max-freq! this new-freq))

    (let ([current-stack (hash-ref current-freq-stacks new-freq '())])
      (hash-set! current-freq-stacks new-freq (cons val current-stack)))))

(define (pop this)
  (let* ([current-freq-map (FreqStack-internal-freq-map this)]
         [current-freq-stacks (FreqStack-internal-freq-stacks this)]
         [current-max-freq (FreqStack-internal-max-freq this)]
         [stack-at-max-freq (hash-ref current-freq-stacks current-max-freq)]
         [top-val (car stack-at-max-freq)]
         [remaining-stack (cdr stack-at-max-freq)])

    (hash-set! current-freq-stacks current-max-freq remaining-stack)

    (hash-set! current-freq-map top-val (sub1 (hash-ref current-freq-map top-val)))

    (when (empty? remaining-stack)
      (set-FreqStack-internal-max-freq! this (sub1 current-max-freq)))

    top-val))