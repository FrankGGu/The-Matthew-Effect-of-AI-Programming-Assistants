#lang racket

(require data/hash)
(require data/sorted-set)

(define (avoid-flood rains-list)
  (define rains (list->vector rains-list))
  (define n (vector-length rains))
  (define ans (make-vector n))
  (define last-flood-day (make-hash))
  (define dry-days-available (sorted-set))
  (define impossible? #f)

  (for ([i (in-range n)])
    (define city-id (vector-ref rains i))

    (cond
      [(= city-id 0)
       (vector-set! ans i 1)
       (set! dry-days-available (sorted-set-add dry-days-available i))]

      [else
       (vector-set! ans i -1)
       (when (hash-has-key? last-flood-day city-id)
         (define prev-flood-day (hash-ref last-flood-day city-id))

         (define found-j-list (sorted-set-find-first-greater-than dry-days-available prev-flood-day))

         (unless (pair? found-j-list)
           (set! impossible? #t)
           (break))

         (define j (car found-j-list))

         (when (>= j i)
           (set! impossible? #t)
           (break))

         (vector-set! ans j city-id)
         (set! dry-days-available (sorted-set-remove dry-days-available j))))

    (when (> city-id 0)
      (hash-set! last-flood-day city-id i)))

  (if impossible?
      '()
      (vector->list ans)))