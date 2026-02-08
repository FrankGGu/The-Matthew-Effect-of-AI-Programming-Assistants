(define (min-deletions s k)
  (define freq (make-hash))
  (for-each (lambda (c) (hash-update! freq c (lambda (x) (+ x 1)) 0)) s)
  (define counts (hash->list freq))
  (define sorted-counts (sort counts (lambda (a b) (> (second a) (second b)))))
  (if (<= (length sorted-counts) k)
      0
      (define excess (- (length sorted-counts) k))
      (define deletions 0)
      (for ((pair (in-list (take sorted-counts excess))))
        (set! deletions (+ deletions (second pair))))
      deletions)))

(min-deletions "aaabbbc" 2)