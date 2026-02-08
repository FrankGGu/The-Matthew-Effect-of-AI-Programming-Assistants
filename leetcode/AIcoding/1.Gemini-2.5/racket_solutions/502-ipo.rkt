#lang racket

(require data/heap)

(define (find-maximized-capital k w profits capitals)
  (define n (vector-length profits))

  (define projects
    (for/list ([i (in-range n)])
      (cons (vector-ref capitals i) (vector-ref profits i))))

  (define sorted-projects
    (sort projects (lambda (p1 p2) (< (car p1) (car p2)))))

  (define affordable-profits-heap (make-heap <))

  (define current-project-index 0)

  (for ([_ (in-range k)])
    (let process-affordable-projects ()
      (when (and (< current-project-index n)
                 (<= (car (list-ref sorted-projects current-project-index)) w))
        (define current-project (list-ref sorted-projects current-project-index))
        (define project-profit (cdr current-project))
        (heap-add! affordable-profits-heap (- project-profit))

        (set! current-project-index (+ current-project-index 1))

        (process-affordable-projects)))

    (when (heap-empty? affordable-profits-heap)
      (break))

    (define max-profit (- (heap-min affordable-profits-heap)))
    (heap-remove-min! affordable-profits-heap)

    (set! w (+ w max-profit)))

  w)