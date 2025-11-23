(define (minimum-time-to-finish-all-jobs jobs k)
  (let* ([n (length jobs)]
         ; Sort jobs in descending order for better pruning
         [sorted-jobs (sort jobs >)]
         ; Initialize min-overall-time to a very large number
         [min-overall-time (expt 10 9)]
         ; worker-loads will be a vector of size k, storing current load for each worker
         [worker-loads (make-vector k 0)])

    (define (backtrack job-idx current-max-load)
      ; Pruning: If the current maximum load is already greater than or equal to
      ; the best result found so far, then this path cannot lead to a better solution.
      (when (< current-max-load min-overall-time)
        (if (= job-idx n)
            ; Base case: All jobs have been assigned. Update the overall minimum time.
            (set! min-overall-time (min min-overall-time current-max-load))
            ; Recursive step: Assign the current job to one of the workers
            (let ([current-job (vector-ref sorted-jobs job-idx)])
              (for ([i (in-range k)])
                (let ([initial-worker-load (vector-ref worker-loads i)])
                  ; Assign current-job to worker i
                  (vector-set! worker-loads i (+ initial-worker-load current-job))
                  ; Recursively call for the next job
                  (backtrack (+ job-idx 1) (max current-max-load (vector-ref worker-loads i)))
                  ; Backtrack: Remove current-job from worker i
                  (vector-set! worker-loads i initial-worker-load)

                  ; Optimization for identical workers:
                  ; If worker i was initially idle (load 0) before assigning current-job,
                  ; and after exploring the path and backtracking, it's idle again,
                  ; it means this worker was effectively the "first" to take a job from an idle state.
                  ; We don't need to try assigning this job to other workers j > i
                  ; if they are also idle, because it would lead to symmetric solutions.
                  (when (= initial-worker-load 0)
                    (break)))))))) ; Stop trying to assign to subsequent workers if this one was initially idle.

    ; Initial call to backtracking: start with the first job (index 0) and max load 0.
    (backtrack 0 0)
    min-overall-time))