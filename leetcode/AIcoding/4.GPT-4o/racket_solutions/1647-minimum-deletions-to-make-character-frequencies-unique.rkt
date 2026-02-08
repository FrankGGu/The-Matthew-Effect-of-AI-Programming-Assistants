(define (min-deletions s)
  (define freq (make-hash))
  (for-each (lambda (c) (hash-update! freq c (λ (x) (+ x 1)) 1)) s)
  (define freqs (hash->list freq))
  (define sorted-freqs (sort freqs >))
  (define (helper lst seen)
    (cond
      [(null? lst) 0]
      [(member (car lst) seen) 
       (let* ((current (car lst))
              (deletion (- current 1)))
         (+ 1 (helper (cdr lst) (cons deletion seen))))]
      [else 
       (helper (cdr lst) (cons (car lst) seen))]))
  (helper sorted-freqs '()))

(min-deletions "aaabbbcc")