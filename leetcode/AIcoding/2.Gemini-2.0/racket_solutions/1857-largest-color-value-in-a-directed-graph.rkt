(define (largest-path-value colors edges)
  (define n (string-length colors))
  (define adj (make-vector n '()))
  (define indegrees (make-vector n 0))
  (for ([edge edges])
    (let ([u (car edge)] [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! indegrees v (+ (vector-ref indegrees v) 1))))

  (define dp (make-vector n (make-vector 26 0)))
  (define queue (list))
  (for ([i (in-range n)])
    (if (= (vector-ref indegrees i) 0)
        (begin
          (vector-set! (vector-ref dp i) (char->integer (string-ref colors i)) 1)
          (set! queue (cons i queue)))))

  (define visited 0)
  (define result 0)

  (while (not (null? queue))
    (let ([u (car queue)])
      (set! queue (cdr queue))
      (set! visited (+ visited 1))
      (set! result (max result (apply max (vector->list (vector-ref dp u)))))

      (for ([v (vector-ref adj u)])
        (for ([i (in-range 26)])
          (let ([new-val (+ (vector-ref (vector-ref dp u) i) (if (= i (char->integer (string-ref colors v))) 1 0))])
            (vector-set! (vector-ref dp v) i (max (vector-ref (vector-ref dp v) i) new-val))))
        (vector-set! indegrees v (- (vector-ref indegrees v) 1))
        (if (= (vector-ref indegrees v) 0)
            (set! queue (cons v queue))))))

  (if (= visited n)
      result
      -1))

(define (char->integer c)
  (- (char->integer c) (char->integer #\a)))