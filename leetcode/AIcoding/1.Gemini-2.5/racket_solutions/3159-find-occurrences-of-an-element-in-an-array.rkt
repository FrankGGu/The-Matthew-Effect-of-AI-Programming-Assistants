(define (find-occurrences arr target queries)
  (let* ([occurrence-indices-list
          (let loop ([lst arr] [idx 0] [acc '()])
            (cond
              [(empty? lst) (reverse acc)]
              [(equal? (car lst) target) (loop (cdr lst) (+ idx 1) (cons idx acc))]
              [else (loop (cdr lst) (+ idx 1) acc)]))]
         [occurrence-indices-vec (list->vector occurrence-indices-list)]
         [num-occurrences (vector-length occurrence-indices-vec)])
    (for/list ([q queries])
      (if (< q num-occurrences)
          (vector-ref occurrence-indices-vec q)
          -1))))