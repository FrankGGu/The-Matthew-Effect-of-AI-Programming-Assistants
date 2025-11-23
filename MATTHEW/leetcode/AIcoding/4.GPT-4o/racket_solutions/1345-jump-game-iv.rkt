(define (min-jumps arr)
  (define n (length arr))
  (define graph (make-vector n '()))

  (for ([i (in-range n)])
    (for ([j (in-range i +1 (min n (+ i 1 (count (lambda (x) (equal? (vector-ref arr i) x)) arr)))))]
      (vector-set! graph i (cons j (vector-ref graph i)))
      (vector-set! graph j (cons i (vector-ref graph j)))))

  (define (bfs)
    (define visited (make-vector n #f))
    (define queue (list 0))
    (vector-set! visited 0 #t)
    (define steps 0)

    (let loop ()
      (if (null? queue)
          -1
          (define size (length queue))
          (for ([i (in-range size)])
            (define current (car queue))
            (set! queue (cdr queue))
            (if (= current (- n 1))
                (return steps))
            (for ([neighbor (vector-ref graph current)])
              (when (not (vector-ref visited neighbor))
                (vector-set! visited neighbor #t)
                (set! queue (append queue (list neighbor))))))
          (set! steps (+ steps 1))
          (loop))))

  (bfs))