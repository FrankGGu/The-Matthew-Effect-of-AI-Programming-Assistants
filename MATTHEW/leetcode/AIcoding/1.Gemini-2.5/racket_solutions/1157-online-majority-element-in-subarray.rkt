#lang racket

(define (make-majority-checker arr)
  (define arr-vec (list->vector arr))
  (define value->indices (make-hash))

  (for ([i (in-range (vector-length arr-vec))])
    (let ((val (vector-ref arr-vec i)))
      (hash-set! value->indices val (cons i (hash-ref value->indices val '())))))

  (for ([(val indices-list) (in-hash value->indices)])
    (hash-set! value->indices val (list->vector (reverse indices-list))))

  (define (binary-search-lower-bound vec target)
    (let loop ((low 0) (high (vector-length vec)))
      (if (< low high)
          (let* ((mid (quotient (+ low high) 2))
                 (val (vector-ref vec mid)))
            (if (< val target)
                (loop (+ mid 1) high)
                (loop low mid)))
          low)))

  (define (binary-search-upper-bound vec target)
    (let loop ((low 0) (high (vector-length vec)))
      (if (< low high)
          (let* ((mid (quotient (+ low high) 2))
                 (val (vector-ref vec mid)))
            (if (<= val target)
                (loop (+ mid 1) high)
                (loop low mid)))
          low)))

  (define (count-occurrences val left right)
    (let ((indices-vec (hash-ref value->indices val #f)))
      (if indices-vec
          (- (binary-search-upper-bound indices-vec right)
             (binary-search-lower-bound indices-vec left))
          0)))

  (define (query left right threshold)
    (define num-samples 20)
    (define len (+ (- right left) 1))

    (let loop ((k 0))
      (if (= k num-samples)
          -1
          (let* ((random-offset (random len))
                 (sample-idx (+ left random-offset))
                 (candidate (vector-ref arr-vec sample-idx))
                 (count (count-occurrences candidate left right)))
            (if (>= count threshold)
                candidate
                (loop (+ k 1)))))))

  query)