(define (max-profit-assign difficulty profit worker)
  ;; Combine difficulty and profit into a list of (difficulty . profit) pairs
  (define jobs
    (map (lambda (d p) (cons d p)) difficulty profit))

  ;; Sort jobs by difficulty in ascending order
  (define sorted-jobs
    (sort jobs (lambda (j1 j2) (< (car j1) (car j2)))))

  ;; Sort workers by ability in ascending order
  (define sorted-worker
    (sort worker <))

  (define total-profit 0)
  (define max-current-profit 0)
  (define job-idx 0)
  (define num-jobs (length sorted-jobs))

  ;; Iterate through each worker
  (for-each (lambda (w)
              ;; While there are jobs left and the current worker can do the job at job-idx
              ;; update max-current-profit to be the maximum profit found so far
              ;; for jobs this worker (and previous workers) can do.
              (let loop ()
                (when (and (< job-idx num-jobs)
                           (<= (car (list-ref sorted-jobs job-idx)) w))
                  (set! max-current-profit
                        (max max-current-profit (cdr (list-ref sorted-jobs job-idx))))
                  (set! job-idx (+ job-idx 1))
                  (loop)))
              ;; Add the maximum profit achievable for this worker to the total profit.
              (set! total-profit (+ total-profit max-current-profit)))
            sorted-worker)

  total-profit)