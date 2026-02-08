(define (get-target-copy original cloned target)
  (cond [(null? original) null]
        [(eq? original target) cloned]
        [else (or (get-target-copy (car original) (car cloned) target)
                  (get-target-copy (cdr original) (cdr cloned) target))]))