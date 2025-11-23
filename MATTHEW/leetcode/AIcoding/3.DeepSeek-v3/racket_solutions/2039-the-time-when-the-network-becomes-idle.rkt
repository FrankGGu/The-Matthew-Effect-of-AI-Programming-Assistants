(define/contract (network-becomes-idle edges patience)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) exact-integer?)
  (let* ([n (add1 (length patience))]
         [graph (make-hash)]
         [dist (make-vector n -1)]
         [queue (make-queue)])
    (for ([edge edges])
      (let ([u (first edge)]
            [v (second edge)])
        (hash-update! graph u (lambda (lst) (cons v lst)) '())
        (hash-update! graph v (lambda (lst) (cons u lst)) '())))
    (enqueue! queue 0)
    (vector-set! dist 0 0)
    (let bfs ()
      (when (not (queue-empty? queue))
        (let ([u (dequeue! queue)])
          (for ([v (hash-ref graph u '())])
            (when (= (vector-ref dist v) -1)
              (vector-set! dist v (+ (vector-ref dist u) 1))
              (enqueue! queue v)))
          (bfs))))
    (let ([max-time 0])
      (for ([i (in-range 1 n)])
        (let* ([d (vector-ref dist i)]
               [p (list-ref patience (sub1 i))]
               [last-send (if (zero? (remainder (* 2 d) p))
                              (- (* 2 d) p)
                              (* p (quotient (* 2 d) p)))]
               [time (+ last-send (* 2 d) 1)])
          (when (> time max-time)
            (set! max-time time))))
      max-time)))