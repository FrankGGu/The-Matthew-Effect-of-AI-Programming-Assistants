#lang racket

(define (largest-path-value colors edges)
  (define n (string-length colors))
  (define adj (make-vector n '()))
  (define in-degree (make-vector n 0))
  (define dp (make-vector n (make-vector 26 0)))

  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! in-degree v (add1 (vector-ref in-degree v)))))

  (define q (make-queue))
  (for ([i (in-range n)])
    (when (zero? (vector-ref in-degree i))
      (enqueue! q i)
      (let ([c (- (char->integer (string-ref colors i)) (char->integer #\a))])
        (vector-set! (vector-ref dp i) c 1))))

  (define cnt 0)
  (define ans 0)

  (while (not (queue-empty? q))
    (define u (dequeue! q))
    (set! cnt (add1 cnt))

    (for ([v (vector-ref adj u)])
      (for ([k (in-range 26)])
        (let ([new-val (if (= k (- (char->integer (string-ref colors v)) (char->integer #\a)))
                           (add1 (vector-ref (vector-ref dp u) k))
                           (vector-ref (vector-ref dp u) k))])
          (when (> new_val (vector-ref (vector-ref dp v) k))
            (vector-set! (vector-ref dp v) k new_val)
            (set! ans (max ans new_val)))))

      (vector-set! in-degree v (sub1 (vector-ref in-degree v)))
      (when (zero? (vector-ref in-degree v))
        (enqueue! q v))))

  (if (= cnt n) ans -1))