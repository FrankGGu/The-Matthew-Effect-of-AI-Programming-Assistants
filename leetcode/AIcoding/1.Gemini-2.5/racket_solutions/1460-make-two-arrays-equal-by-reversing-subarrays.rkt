(define (can-be-equal target arr)
  (equal? (sort target <) (sort arr <)))