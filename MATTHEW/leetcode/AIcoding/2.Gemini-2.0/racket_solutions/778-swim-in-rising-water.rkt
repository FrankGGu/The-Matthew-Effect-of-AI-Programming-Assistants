(define (swim-in-rising-water grid)
  (let* ([n (vector-length grid)]
         [visited (make-vector n (make-vector n #f))]
         [min-heap (make-heap < #:key (lambda (x) (vector-ref x 2)))]
         [directions '((0 1) (0 -1) (1 0) (-1 0))])

    (vector-set! visited 0 (make-vector n #f))
    (vector-set! (vector-ref visited 0) 0 #t)
    (heap-add! min-heap (vector 0 0 (vector-ref (vector-ref grid 0) 0)))

    (let loop ()
      (if (heap-empty? min-heap)
          #f
          (let* ([curr (heap-remove-min! min-heap)]
                 [r (vector-ref curr 0)]
                 [c (vector-ref curr 1)]
                 [val (vector-ref curr 2)])
            (if (and (= r (- n 1)) (= c (- n 1)))
                val
                (for-each
                 (lambda (dir)
                   (let* ([new-r (+ r (car dir))]
                          [new-c (+ c (cadr dir))])
                     (if (and (>= new-r 0) (< new-r n)
                              (>= new-c 0) (< new-c n)
                              (not (vector-ref (vector-ref visited new-r) new-c)))
                         (begin
                           (vector-set! (vector-ref visited new-r) new-c #t)
                           (heap-add! min-heap (vector new-r new-c (max val (vector-ref (vector-ref grid new-r) new-c))))))))
                 directions)
                (loop)))))))