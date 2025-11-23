(define (can-reach-all-targets? distances)
  (let ([n (length distances)])
    (if (zero? n)
        #t
        (let loop ([curr 0] [visited (make-vector n #f)] [count 0])
          (if (= count n)
              #t
              (let* ([dist (vector-ref distances curr)]
                     [next (modulo (+ curr dist) n)])
                (if (vector-ref visited next)
                    #f
                    (begin
                      (vector-set! visited next #t)
                      (loop next (vector-copy visited) (+ count 1)))))))))))