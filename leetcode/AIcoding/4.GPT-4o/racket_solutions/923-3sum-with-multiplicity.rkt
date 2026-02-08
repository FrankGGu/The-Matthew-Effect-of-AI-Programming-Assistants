(define (threeSumMulti A target)
  (define (count-pairs lst val)
    (let loop ((lst lst) (count 0) (map (hash) ()))
      (cond
        [(null? lst) count]
        [else
         (let ((num (car lst)))
           (if (hash-has? map num)
               (loop (cdr lst) (+ count (hash-ref map num)) map)
               (loop (cdr lst) count (hash-set! map num (+ (hash-ref map num 0) 1)))))])))

  (define (count-triplets lst val)
    (define n (length lst))
    (define result 0)
    (for ((i (in-range n)))
      (define pairs-count (count-pairs (append (take lst i) (drop lst (+ i 1))) (- val (list-ref lst i))))
      (set! result (+ result pairs-count)))
    result)

  (define sorted-A (sort A <))
  (count-triplets sorted-A target))

(threeSumMulti '(1 2 2 3 4) 7)