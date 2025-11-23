#lang racket

(define (find-most-common-response responses)
  (if (empty? responses)
      #f ; Return #f for an empty list, or handle as per specific problem requirements
      (let ([counts (make-hash)])
        ;; Populate counts for each response
        (for-each (lambda (response)
                    (hash-update! counts response add1 0))
                  responses)

        ;; Find the item with the maximum count
        (let-values (((most-common-item max-count)
                      (hash-fold (lambda (item count acc-item acc-count)
                                   (if (> count acc-count)
                                       (values item count)
                                       (values acc-item acc-count)))
                                 ;; Initialize accumulator with the first response and its count
                                 (values (car responses) (hash-ref counts (car responses)))
                                 counts)))
          most-common-item))))