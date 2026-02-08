#lang racket

(struct employee (id importance subordinates))

(define (get-importance employees id)
  (define employee-map (make-hash))

  (for-each (lambda (emp)
              (hash-set! employee-map (employee-id emp) emp))
            employees)

  (define (dfs current-ids current-total)
    (if (empty? current-ids)
        current-total
        (let* ((current-id (car current-ids))
               (rest-ids (cdr current-ids))
               (current-employee (hash-ref employee-map current-id #f)))
          (if current-employee
              (let* ((importance (employee-importance current-employee))
                     (subordinates (employee-subordinates current-employee))
                     (new-total (+ current-total importance))
                     (new-ids (append subordinates rest-ids)))
                (dfs new-ids new-total))
              (dfs rest-ids current-total)))))

  (dfs (list id) 0))