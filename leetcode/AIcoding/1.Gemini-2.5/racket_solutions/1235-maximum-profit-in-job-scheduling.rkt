#lang racket

(require data/rbt)

(define (job-scheduling start-time end-time profit)
  (let* ([n (vector-length start-time)]
         [jobs (build-list n (lambda (i)
                               (list (vector-ref start-time i)
                                     (vector-ref end-time i)
                                     (vector-ref profit i))))]
         [sorted-jobs (sort jobs (lambda (j1 j2)
                                   (< (second j1) (second j2))))]
         [dp (rbt-map-set (rbt-map) 0 0)])

    (for-each (lambda (job)
                (let* ([s (first job)]
                       [e (second job)]
                       [p (third job)]
                       [prev-profit (rbt-map-ref-le dp s 0)]
                       [current-job-profit (+ p prev-profit)]
                       [max-profit-so-far (rbt-map-max-val dp)])

                  (when (> current-job-profit max-profit-so-far)
                    (set! dp (rbt-map-set dp e current-job-profit)))))
              sorted-jobs)

    (rbt-map-max-val dp)))