#lang racket/base

(define (total-appeal s)
  (let* ((n (string-length s))
         (last-seen-indices (make-hash))) ; Stores char -> last_index
    (for/sum ([i (in-range n)])
      (let* ((char (string-ref s i))
             (last-idx (hash-ref last-seen-indices char -1)) ; Default -1 if not seen
             (left-count (- i last-idx))
             (right-count (- n i)))
        (hash-set! last-seen-indices char i) ; Update last seen index for char
        (* left-count right-count)))))