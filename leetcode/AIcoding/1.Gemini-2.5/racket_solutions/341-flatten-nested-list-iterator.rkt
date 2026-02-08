(require racket/base)

(define-struct NestedIterator (stack) #:mutable)

(define (NestedIterator-init nestedList)
  (let ((s '()))
    (for-each (lambda (ni) (set! s (cons ni s)))
              (reverse nestedList))
    (make-NestedIterator s)))

(define (NestedIterator-hasNext! iterator)
  (let loop ()
    (let ((current-stack (NestedIterator-stack iterator)))
      (cond
        ((empty? current-stack) #f)
        ((nested-integer-is-integer? (car current-stack)) #t)
        (else
         (let* ((top-list-ni (car current-stack))
                (inner-list (nested-integer-get-list top-list-ni)))
           (set-NestedIterator-stack! iterator (cdr current-stack))
           (for-each (lambda (ni) (set-NestedIterator-stack! iterator (cons ni (NestedIterator-stack iterator))))
                     (reverse inner-list))
           (loop)))))))

(define (NestedIterator-next! iterator)
  (let* ((current-stack (NestedIterator-stack iterator))
         (top-integer-ni (car current-stack))
         (val (nested-integer-get-integer top-integer-ni)))
    (set-NestedIterator-stack! iterator (cdr current-stack))
    val))