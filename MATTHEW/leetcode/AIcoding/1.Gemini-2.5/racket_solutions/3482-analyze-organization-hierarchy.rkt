#lang racket

(define (analyze-organization-hierarchy employees)
  (define reports-map (make-hash))
  (define all-employee-ids (make-hash))

  (for-each
   (lambda (employee)
     (define employee-id (first employee))
     (define manager-id (second employee))
     (hash-set! all-employee-ids employee-id #t)

     (when (not (= manager-id -1))
       (hash-update! reports-map manager-id
                     (lambda (reports) (cons employee-id reports))
                     '())))
   employees)

  (define (count-subordinates employee-id)
    (define direct-reports (hash-ref reports-map employee-id '()))
    (if (null? direct-reports)
        0
        (+ (length direct-reports)
           (apply + (map count-subordinates direct-reports)))))

  (define results (make-hash))
  (for-each
   (lambda (employee)
     (define employee-id (first employee))
     (hash-set! results employee-id (count-subordinates employee-id)))
   employees)

  (define sorted-employee-ids (sort (hash-keys all-employee-ids) <))
  (map (lambda (id) (list id (hash-ref results id))) sorted-employee-ids))