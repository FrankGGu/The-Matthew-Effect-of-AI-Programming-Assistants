(define (findLucky arr)
  (define counts (make-hash))
  (for-each (lambda (x) (hash-update! counts x (lambda (v) (+ v 1)) 1)) arr)
  (define lucky '(0))
  (for-each (lambda (key) (when (= key (hash-ref counts key)) (set! lucky (max lucky key)))) (hash-keys counts))
  (if (= lucky 0) -1 lucky))

(findLucky [2, 2, 3, 4]) ; Example usage