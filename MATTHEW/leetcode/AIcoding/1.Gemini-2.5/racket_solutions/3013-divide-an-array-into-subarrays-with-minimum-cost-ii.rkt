#lang racket
(require data/heap)

(define (minimum-cost nums k min-length)
  (define n (vector-length nums))

  ;; dp-prev stores the minimum cost to form `j-1` additional subarrays,
  ;; where the last one starts at index `p`.
  ;; dp-prev[0] = 0 (cost of 0 additional subarrays is 0, conceptually ending at index 0)
  ;; All other dp-prev[i] = +inf.0
  (define dp-prev (build-vector n (lambda (i) +inf.0)))
  (vector-set! dp-prev 0 0)

  ;; Loop for `j` from 1 to `k-1`. `j` represents the `j`-th additional subarray to choose.
  (for ([j (in-range 1 k)])
    (define dp-curr (build-vector n (lambda (i) +inf.0)))
    (define pq (make-heap <)) ; Min-heap to store (cost) values

    ;; p-add-limit-for-prev-dp is the pointer for `p` in `dp-prev` to add to the heap.
    ;; It starts from the earliest possible index for the (j-1)-th additional subarray.
    (define p-add-limit-for-prev-dp (* (- j 1) min-length))

    ;; Loop for `i`, which is the starting index of the `j`-th additional subarray.
    ;; `i` must be at least `j * min_length` (to accommodate `j` subarrays before it).
    ;; `i` must be at most `n - (k-j)*min_length` (to accommodate `k-j` subarrays after it).
    (for ([i (in-range (* j min-length) n)])
      ;; Calculate the maximum valid index `p` for `dp-prev` for the current `j`.
      ;; This ensures `p` is within the bounds for `j-1` subarrays and leaves enough space for `k-j` more.
      (define p-max-for-prev-dp-valid (- n (* (- k j -1) min-length)))

      ;; Add elements to `pq`
      ;; `p` must be `p <= i - min_length`.
      ;; `p` must also be a valid index in `dp-prev` (checked by `p-max-for-prev-dp-valid` and `dp-prev` value).
      (let loop-add-to-heap ()
        (when (and (<= p-add-limit-for-prev-dp (- i min-length))
                   (<= p-add-limit-for-prev-dp p-max-for-prev-dp-valid)
                   (< p-add-limit-for-prev-dp n)) ; Ensure p-add-limit-for-prev-dp is a valid vector index
          (let ([prev-cost (vector-ref dp-prev p-add-limit-for-prev-dp)])
            (unless (equal? prev-cost +inf.0)
              (heap-add! pq prev-cost)))
          (set! p-add-limit-for-prev-dp (+ p-add-limit-for-prev-dp 1))
          (loop-add-to-heap)))

      ;; Get the minimum cost from the previous stage.
      (unless (heap-empty? pq)
        (define min-prev-cost (heap-min-val pq))
        (when (not (equal? min-prev-cost +inf.0))
          (vector-set! dp-curr i (+ (vector-ref nums i) min-prev-cost)))))

    (set! dp-prev dp-curr))

  ;; After `k-1` iterations, `dp-prev` contains the minimum costs for `k-1` additional subarrays.
  ;; The last subarray must start at `i` such that `n - i >= min_length`.
  ;; So `i <= n - min_length`.
  ;; The earliest `i` can be is `(k-1)*min_length`.
  (define min-additional-cost +inf.0)
  (for ([i (in-range (* (- k 1) min-length) n)])
    (when (<= i (- n min-length))
      (define cost (vector-ref dp-prev i))
      (unless (equal? cost +inf.0)
        (set! min-additional-cost (min min-additional-cost cost)))))

  ;; If no valid division was found, min-additional-cost will be +inf.0
  (if (equal? min-additional-cost +inf.0)
      +inf.0
      (+ (list-ref nums 0) min-additional-cost)))