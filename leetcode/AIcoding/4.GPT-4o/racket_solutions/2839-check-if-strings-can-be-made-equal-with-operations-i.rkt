(define (canBeEqual target arr)
  (equal? (sort target <) (sort arr <)))