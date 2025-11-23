#lang racket

(define (most-visited n rounds)
  (let* ((num-sectors (+ n 1))
         (counts (make-vector num-sectors 0))
         (len-rounds (length rounds)))

    (for ((i (in-range (- len-rounds 1))))
      (let ((start-sector (list-ref rounds i))
            (end-sector (list-ref rounds (+ i 1))))
        (if (<= start-sector end-sector)
            (for ((j (in-range start-sector (+ end-sector 1))))
              (vector-set! counts j (+ (vector-ref counts j) 1)))
            (begin
              (for ((j (in-range start-sector (+ n 1))))
                (vector-set! counts j (+ (vector-ref counts j) 1)))
              (for ((j (in-range 1 (+ end-sector 1))))
                (vector-set! counts j (+ (vector-ref counts j) 1)))))))

    (let ((max-count 0))
      (for ((j (in-range 1 (+ n 1))))
        (set! max-count (max max-count (vector-ref counts j))))

      (let ((result '()))
        (for ((j (in-range 1 (+ n 1))))
          (when (= (vector-ref counts j) max-count)
            (set! result (append result (list j)))))
        result))))