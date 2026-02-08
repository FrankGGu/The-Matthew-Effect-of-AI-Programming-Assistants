#lang racket

(define (find-all-people-with-secret n meetings firstPerson)
  ;; DSU structure
  ;; parent vector stores the parent of each person.
  ;; It will be initialized once, and then temporarily modified and restored for each time batch.
  (define parent (make-vector n 0))

  ;; Finds the root of the set containing element i, with path compression
  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ([root (find (vector-ref parent i))])
          (vector-set! parent i root)
          root)))

  ;; Unions the sets containing elements i and j
  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (vector-set! parent root-j root-i)
        #t)))

  ;; Initialize known-secret array
  (define known-secret (make-vector n #f))
  (vector-set! known-secret 0 #t) ; Person 0 always has the secret
  (vector-set! known-secret firstPerson #t) ; firstPerson also has the secret

  ;; Sort meetings by time
  (define sorted-meetings (sort meetings (lambda (m1 m2) (< (list-ref m1 2) (list-ref m2 2)))))

  ;; Process meetings in time batches
  (define (process-meetings-by-time current-idx)
    (when (< current-idx (length sorted-meetings))
      (let* ([current-time (list-ref (list-ref sorted-meetings current-idx) 2)]
             [meetings-at-this-time (list)]
             [people-involved (set)] ; Use a set to store unique people involved in this time batch
             [idx current-idx])

        ;; Collect all meetings at current-time and people involved
        (while (and (< idx (length sorted-meetings))
                    (= (list-ref (list-ref sorted-meetings idx) 2) current-time))
          (let* ([m (list-ref sorted-meetings idx)]
                 [p1 (list-ref m 0)]
                 [p2 (list-ref m 1)])
            (set! meetings-at-this-time (cons m meetings-at-this-time))
            (set! people-involved (set-add people-involved p1))
            (set! people-involved (set-add people-involved p2))
            (set! idx (+ idx 1))))

        ;; Reset DSU for people involved in this batch
        ;; This ensures that connections are only considered within the current time batch.
        (for ([p (in-set people-involved)])
          (vector-set! parent p p))

        ;; Perform unions for meetings at current-time
        (for ([m (reverse meetings-at-this-time)]) ; Process in original order
          (union (list-ref m 0) (list-ref m 1)))

        ;; Determine which components get the secret
        (define roots-with-secret (set))
        (for ([p (in-set people-involved)])
          (when (vector-ref known-secret p)
            (set! roots-with-secret (set-add roots-with-secret (find p)))))

        ;; Propagate secret within components
        (for ([p (in-set people-involved)])
          (when (set-member? roots-with-secret (find p))
            (vector-set! known-secret p #t)))

        ;; Continue with next batch of meetings
        (process-meetings-by-time idx))))

  ;; Start processing
  (process-meetings-by-time 0)

  ;; Collect all people who know the secret
  (define result (list))
  (for ([i (range n)])
    (when (vector-ref known-secret i)
      (set! result (cons i result))))
  (sort result <)) ; Sort the final list