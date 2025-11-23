(define (longestCycle edges)
  (define n (length edges))
  (define visited (make-vector n #f))
  (define recStack (make-vector n #f))
  (define max-length -1)

  (define (dfs node depth)
    (if (vector-ref visited node)
        (if (vector-ref recStack node)
            (begin
              (set! max-length (max max-length depth))
              #t)
            #f)
        (begin
          (vector-set! visited node #t)
          (vector-set! recStack node #t)
          (if (and (not (= (vector-ref edges node) -1))
                   (dfs (vector-ref edges node) (+ depth 1)))
              #t
              (begin
                (vector-set! recStack node #f)
                #f)))))

  (for ([i (in-range n)])
    (if (not (vector-ref visited i))
        (dfs i 0)))

  (if (= max-length -1) -1 max-length))

(longestCycle (vector -1 0 1 2)) ; Adjust input as needed