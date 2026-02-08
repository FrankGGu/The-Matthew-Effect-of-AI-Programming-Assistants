#lang racket
(require data/red-black-tree)

(struct seat-manager (available-seats) #:mutable)

(define (seat-manager-init n)
  (let loop ((i 1) (s (rbt-set)))
    (if (> i n)
        (seat-manager s)
        (loop (+ i 1) (rbt-set-add s i)))))

(define (seat-manager-reserve sm)
  (let* ((available (seat-manager-available-seats sm))
         (min-seat (rbt-set-min available)))
    (set-seat-manager-available-seats sm (rbt-set-remove available min-seat))
    min-seat))

(define (seat-manager-unreserve sm seat-number)
  (let ((available (seat-manager-available-seats sm)))
    (set-seat-manager-available-seats sm (rbt-set-add available seat-number))))