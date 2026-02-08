#lang racket

(define (is-possible-divide nums k)
  (define n (length nums))

  (if (not (= (modulo n k) 0))
      #f
      (let ()
        (define counts (make-hash))
        (for-each (lambda (x)
                    (hash-update! counts x add1 0))
                  nums)

        (define sorted-unique-nums (sort (hash-keys counts) <))

        (let loop ((idx 0))
          (if (>= idx (length sorted-unique-nums))
              #t
              (let* ((x (list-ref sorted-unique-nums idx))
                     (x-count (hash-ref counts x 0)))
                (if (= x-count 0)
                    (loop (+ idx 1))
                    (let inner-loop ((i 0))
                      (if (>= i k)
                          (loop (+ idx 1))
                          (let* ((current-val (+ x i))
                                 (val-count (hash-ref counts current-val 0)))
                            (if (< val-count x-count)
                                #f
                                (begin
                                  (hash-set! counts current-val (- val-count x-count))
                                  (inner-loop (+ i 1))))))))))))))