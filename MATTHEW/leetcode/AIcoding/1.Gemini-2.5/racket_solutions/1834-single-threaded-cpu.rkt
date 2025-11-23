(require data/heap)

(define (single-threaded-cpu tasks)
  (define n (length tasks))

  ;; Augment tasks with original indices and sort by enqueue time.
  ;; Each element in tasks-with-indices will be (enqueueTime processingTime originalIndex).
  (define tasks-with-indices
    (let ((indexed-tasks (map (lambda (task idx) (list (car task) (cadr task) idx))
                              tasks
                              (range n))))
      (sort indexed-tasks (lambda (a b) (< (car a) (car b))))))

  ;; Priority queue for available tasks.
  ;; Stores (processing-time . original-index).
  ;; Comparison: shortest processing time, then smallest original index.
  (define available-tasks-pq
    (make-heap (lambda (a b)
                 (or (< (car a) (car b))
                     (and (= (car a) (car b))
                          (< (cdr a) (cdr b)))))))

  (define current-time 0)
  (define processed-order '()) ; Accumulate results using cons, then reverse at the end.
  (define current-task-list tasks-with-indices) ; A mutable pointer to the remaining tasks to be enqueued.

  (let loop ()
    ;; Continue as long as there are tasks to enqueue OR tasks in the priority queue.
    (when (or (not (null? current-task-list)) (not (heap-empty? available-tasks-pq)))
      ;; Phase 1: Enqueue all tasks whose enqueueTime is <= current-time.
      (let enqueue-eligible-tasks-loop ()
        (when (and (not (null? current-task-list))
                   (<= (car (car current-task-list)) current-time))
          (let* ((task-data (car current-task-list))
                 (processing-time (cadr task-data))
                 (original-index (caddr task-data)))
            (heap-add! available-tasks-pq (cons processing-time original-index))
            (set! current-task-list (cdr current-task-list))
            (enqueue-eligible-tasks-loop))))

      ;; Phase 2: Process a task or advance current-time if CPU is idle.
      (cond
        ((not (heap-empty? available-tasks-pq))
         ;; CPU is not idle, pick the next task from PQ.
         (let* ((min-task (heap-extract-min! available-tasks-pq))
                (processing-time (car min-task))
                (original-index (cdr min-task)))
           (set! current-time (+ current-time processing-time))
           (set! processed-order (cons original-index processed-order))))
        ((not (null? current-task-list))
         ;; CPU is idle and PQ is empty, but there are future tasks.
         ;; Advance current-time to the enqueue time of the next task.
         (set! current-time (car (car current-task-list))))
        (else
         ;; Both PQ empty and no more tasks to enqueue.
         ;; This branch will be reached when the problem is fully solved,
         ;; and the outer `when` condition will then evaluate to false,
         ;; terminating the loop.
         #f))) ; No operation needed here.

    ;; Recurse for the next iteration of the main loop.
    (when (or (not (null? current-task-list)) (not (heap-empty? available-tasks-pq)))
      (loop)))

  (reverse processed-order))