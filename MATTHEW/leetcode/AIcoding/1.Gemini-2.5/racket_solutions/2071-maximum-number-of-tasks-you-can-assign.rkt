#lang racket

(require data/heap)

(define (can-assign? k tasks-vec workers-vec pills strength)
  (define num-tasks (vector-length tasks-vec))
  (define num-workers (vector-length workers-vec))

  (define current-pills pills)
  (define worker-idx 0) ; Pointer to the weakest available worker

  (define available-workers-for-pills (make-heap <))

  ;; Use a named let for the main loop, allowing early exit
  (let check-loop ([task-idx 0])
    (cond
      [(= task-idx k) ; All k tasks assigned successfully
       #t]
      [else
       (define t (vector-ref tasks-vec task-idx))

       ;; Process workers:
       ;; 1. Skip workers too weak even with a pill for the current task 't'.
       ;; 2. Add workers too weak for 't' without a pill, but strong enough with a pill, to the heap.
       (let loop-workers ()
         (when (< worker-idx num-workers)
           (define current-worker-strength (vector-ref workers-vec worker-idx))
           (cond
             [(< (+ current-worker-strength strength) t)
              ;; Worker is too weak even with a pill for this task, skip it.
              (set! worker-idx (+ worker-idx 1))
              (loop-workers)]
             [(< current-worker-strength t)
              ;; Worker is too weak for 't' without a pill, but strong enough with a pill.
              ;; Add to heap for potential pill usage.
              (heap-add! available-workers-for-pills current-worker-strength)
              (set! worker-idx (+ worker-idx 1))
              (loop-workers)]
             [else
              ;; current-worker-strength >= t, this worker is strong enough without a pill.
              ;; Stop adding to heap for now, this worker is a candidate for direct assignment.
              #f]))) ; Exit loop-workers

       ;; Try to assign the current task 't'
       (cond
         [(and (< worker-idx num-workers) (>= (vector-ref workers-vec worker-idx) t))
          ;; We have a worker strong enough without a pill.
          ;; Consider if using a pill on a weaker worker from the heap is more optimal.
          (if (and (not (heap-empty? available-workers-for-pills))
                   (> current-pills 0)
                   (< (heap-min available-workers-for-pills) (vector-ref workers-vec worker-idx)))
              ;; Use a pill on the weakest worker from the heap if that worker is weaker
              ;; than the current direct worker. This saves the stronger direct worker.
              (begin
                (heap-remove-min! available-workers-for-pills)
                (set! current-pills (- current-pills 1)))
              ;; Otherwise, use the current direct worker.
              (set! worker-idx (+ worker-idx 1)))
          (check-loop (+ task-idx 1))] ; Assigned, continue to next task
         [(and (not (heap-empty? available-workers-for-pills)) (> current-pills 0))
          ;; No worker strong enough without a pill, but we have workers in the heap
          ;; that can be used with a pill, and we have pills.
          (heap-remove-min! available-workers-for-pills)
          (set! current-pills (- current-pills 1))
          (check-loop (+ task-idx 1))] ; Assigned, continue to next task
         [else
          ;; Cannot assign this task.
          #f]))])) ; Early exit with #f

(define (maximum-tasks tasks workers pills strength)
  (define num-tasks (length tasks))
  (define num-workers (length workers))

  (define sorted-tasks (list->vector (sort tasks <)))
  (define sorted-workers (list->vector (sort workers <)))

  (define low 0)
  (define high (min num-tasks num-workers))
  (define ans 0)

  ;; Binary search for the maximum k
  (let loop ([l low] [h high] [current-ans ans])
    (if (> l h)
        current-ans
        (let ([mid (+ l (quotient (- h l) 2))])
          (if (can-assign? mid sorted-tasks sorted-workers pills strength)
              (loop (+ mid 1) h mid) ; Possible to assign 'mid' tasks, try for more
              (loop l (- mid 1) current-ans))))) ; Not possible, try fewer tasks
  )

(define (maximum-number-of-tasks-you-can-assign tasks workers pills strength)
  (maximum-tasks tasks workers pills strength))