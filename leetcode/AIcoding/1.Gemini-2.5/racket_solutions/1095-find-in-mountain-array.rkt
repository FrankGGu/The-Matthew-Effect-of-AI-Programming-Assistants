#lang racket

(define (find-peak mountainArr len)
  (let loop ((low 0) (high (- len 1)))
    (if (< low high)
        (let* ((mid (quotient (+ low high) 2))
               (val-mid (mountain-array-get mountainArr mid))
               (val-mid+1 (mountain-array-get mountainArr (+ mid 1))))
          (if (< val-mid val-mid+1)
              ;; We are on the increasing slope, peak is to the right
              (loop (+ mid 1) high)
              ;; We are on the decreasing slope or at the peak, peak is mid or to the left
              (loop low mid)))
        low)))

(define (binary-search-increasing mountainArr target low high)
  (let loop ((l low) (h high))
    (if (<= l h)
        (let* ((mid (quotient (+ l h) 2))
               (val (mountain-array-get mountainArr mid)))
          (cond
            ((= val target) mid)
            ((< val target) (loop (+ mid 1) h))
            (else (loop l (- mid 1)))))
        -1)))

(define (binary-search-decreasing mountainArr target low high)
  (let loop ((l low) (h high))
    (if (<= l h)
        (let* ((mid (quotient (+ l h) 2))
               (val (mountain-array-get mountainArr mid)))
          (cond
            ((= val target) mid)
            ((< val target) (loop l (- mid 1))) ; Target is smaller, search left in decreasing part
            (else (loop (+ mid 1) h))))          ; Target is larger, search right in decreasing part
        -1)))

(define (find-in-mountain-array target mountainArr)
  (let* ((len (mountain-array-length mountainArr))
         (peak-idx (find-peak mountainArr len)))

    ;; First, search in the increasing part of the array (from 0 to peak-idx)
    (let ((result (binary-search-increasing mountainArr target 0 peak-idx)))
      (if (!= result -1)
          result
          ;; If not found, search in the decreasing part (from peak-idx + 1 to end)
          (binary-search-decreasing mountainArr target (+ peak-idx 1) (- len 1))))))