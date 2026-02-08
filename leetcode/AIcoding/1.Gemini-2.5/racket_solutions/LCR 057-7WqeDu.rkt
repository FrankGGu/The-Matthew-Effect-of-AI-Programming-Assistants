#lang racket

(require racket/for)

(define (contains-nearby-almost-duplicate nums k t)
  (define n (vector-length nums))

  (if (or (<= k 0) (< t 0))
      #f
      (let ()
        (define bucket-map (make-hash))
        (define bucket-size (+ t 1))

        (for/first ([i (in-range n)])
          (define num (vector-ref nums i))
          (define bucket-id (floor (/ num bucket-size)))

          (cond
            [(and (hash-has-key? bucket-map bucket-id)
                  (<= (abs (- num (hash-ref bucket-map bucket-id))) t))
             #t]
            [(and (hash-has-key? bucket-map (- bucket-id 1))
                  (<= (abs (- num (hash-ref bucket-map (- bucket-id 1)))) t))
             #t]
            [(and (hash-has-key? bucket-map (+ bucket-id 1))
                  (<= (abs (- num (hash-ref bucket-map (+ bucket-id 1)))) t))
             #t]
            [else
             (hash-set! bucket-map bucket-id num)
             (when (>= i k)
               (define old-num (vector-ref nums (- i k)))
               (define old-bucket-id (floor (/ old-num bucket-size)))
               (hash-remove! bucket-map old-bucket-id))
             #f]))

        #f)))