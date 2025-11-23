(define (inventory-management-iii stock k)
  (let* ((sorted-stock (sort stock >))
         (top-k-items (take sorted-stock k)))
    (apply + top-k-items)))