#lang racket

(define (find-longest-equal-subarray nums k)
  (define n (vector-length nums))
  (define map-val-to-indices (make-hash))

  (for ([i (in-range n)])
    (define val (vector-ref nums i))
    (hash-set! map-val-to-indices val
               (cons i (hash-ref map-val-to-indices val '()))))

  (for ([val (hash-keys map-val-to-indices)])
    (hash-set! map-val-to-indices val (list->vector (reverse (hash-ref map-val-to-indices val)))))

  (define max-len 0)

  (for ([idx-vec (in-hash-values map-val-to-indices)])
    (define current-left 0)
    (define vec-len (vector-length idx-vec))

    (for ([current-right (in-range vec-len)])
      (define current-val-count (+ (- current-right current-left) 1))
      (define total-span-length (+ (- (vector-ref idx-vec current-right) (vector-ref idx-vec current-left)) 1))
      (define deletions-needed (- total-span-length current-val-count))

      (let loop ()
        (when (> deletions-needed k)
          (set! current-left (+ current-left 1))
          (set! current-val-count (+ (- current-right current-left) 1))
          (set! total-span-length (+ (- (vector-ref idx-vec current-right) (vector-ref idx-vec current-left)) 1))
          (set! deletions-needed (- total-span-length current-val-count))
          (loop)))

      (set! max-len (max max-len current-val-count))))

  max-len)