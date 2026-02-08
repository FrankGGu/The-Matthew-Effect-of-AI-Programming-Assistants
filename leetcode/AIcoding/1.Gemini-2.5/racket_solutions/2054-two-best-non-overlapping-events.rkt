#lang racket

(define (two-best-non-overlapping-events events)
  (define N (length events))

  (define sorted-events-list
    (sort events (lambda (e1 e2)
                   (< (list-ref e1 0) (list-ref e2 0)))))
  (define events-vec (list->vector sorted-events-list))

  (define suffix-max-values (make-vector N 0))
  (when (> N 0)
    (vector-set! suffix-max-values (- N 1) (list-ref (vector-ref events-vec (- N 1)) 2))
    (for ([k (in-range (- N 2) -1 -1)])
      (vector-set! suffix-max-values k
                   (max (list-ref (vector-ref events-vec k) 2)
                        (vector-ref suffix-max-values (+ k 1))))))

  (define (find-first-ge-start-time target-start-time low high)
    (let loop ((l low) (h high) (ans high))
      (if (>= l h)
          ans
          (let* ((mid (+ l (quotient (- h l) 2)))
                 (event-start-time (list-ref (vector-ref events-vec mid) 0)))
            (if (>= event-start-time target-start-time)
                (loop l mid mid)
                (loop (+ mid 1) h ans))))))

  (define max-total-value 0)
  (define max-single-event-value 0)

  (for ([i (in-range N)])
    (define current-event (vector-ref events-vec i))
    (define e_i (list-ref current-event 1))
    (define v_i (list-ref current-event 2))

    (set! max-single-event-value (max max-single-event-value v_i))

    (define j (find-first-ge-start-time (+ e_i 1) (+ i 1) N))

    (when (< j N)
      (set! max-total-value (max max-total-value (+ v_i (vector-ref suffix-max-values j))))))

  (max max-total-value max-single-event-value))