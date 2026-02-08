(define (processTasks tasks batchSize)
  (define (helper tasks batch)
    (if (null? tasks)
        (list)
        (cons (take tasks batch) (helper (drop tasks batch) batch))))
  (helper tasks batchSize))

(define (processTasksWrapper tasks batchSize)
  (map (lambda (task) (list-ref task 0)) (processTasks tasks batchSize)))