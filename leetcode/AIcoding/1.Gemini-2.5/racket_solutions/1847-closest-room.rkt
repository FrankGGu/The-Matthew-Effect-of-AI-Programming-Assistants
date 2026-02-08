#lang racket
(require racket/sorted-set)

(define (closest-room rooms queries)
  (define indexed-queries
    (for/list ([q queries] [idx (in-naturals)])
      (append q (list idx))))

  (define sorted-rooms
    (sort rooms (lambda (r1 r2) (> (second r1) (second r2)))))

  (define sorted-indexed-queries
    (sort indexed-queries (lambda (q1 q2) (> (second q1) (second q2)))))

  (define num-queries (length queries))
  (define results (make-vector num-queries -1))

  (define room-ids-set (sorted-set))

  (define room-ptr 0)

  (for ([query sorted-indexed-queries])
    (define preferred-id (first query))
    (define min-size (second query))
    (define original-idx (third query))

    (let loop ()
      (when (< room-ptr (length sorted-rooms))
        (define current-room (list-ref sorted-rooms room-ptr))
        (when (>= (second current-room) min-size)
          (set! room-ids-set (sorted-set-add room-ids-set (first current-room)))
          (set! room-ptr (add1 room-ptr))
          (loop))))

    (define current-closest-id -1)
    (define min-diff +inf.0)

    (define-values (found-id insert-idx) (sorted-set-find room-ids-set preferred-id))

    (cond
      [found-id
       (set! current-closest-id preferred-id)]
      [else
       (when (> insert-idx 0)
         (define floor-candidate (sorted-set-ref room-ids-set (sub1 insert-idx)))
         (define diff (abs (- floor-candidate preferred-id)))
         (set! min-diff diff)
         (set! current-closest-id floor-candidate))

       (when (< insert-idx (sorted-set-count room-ids-set))
         (define ceiling-candidate (sorted-set-ref room-ids-set insert-idx))
         (define diff (abs (- ceiling-candidate preferred-id)))
         (cond
           [(< diff min-diff)
            (set! min-diff diff)
            (set! current-closest-id ceiling-candidate)]
           [(and (= diff min-diff) (< ceiling-candidate current-closest-id))
            (set! current-closest-id ceiling-candidate)]))])

    (vector-set! results original-idx current-closest-id))

  (vector->list results))