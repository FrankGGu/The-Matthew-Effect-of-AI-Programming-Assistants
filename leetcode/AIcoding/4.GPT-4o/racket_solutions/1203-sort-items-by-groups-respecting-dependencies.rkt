(define (sortItems n m group items)
  (define graph (make-vector n '()))
  (define group-graph (make-vector m '()))
  (define in-degree (make-vector n 0))
  (define group-in-degree (make-vector m 0))

  (for ([i (in-range (vector-length items))])
    (let ([g (if (= (vector-ref group i) -1) (vector-set! group i m) (vector-ref group i)))]
      (vector-set! (vector-ref group-graph g) (vector-ref items i) (cons i (vector-ref (vector-ref group-graph g))))))

  (for ([i (in-range (vector-length items))])
    (for ([dep (in-list (vector-ref items i))])
      (vector-set! (vector-ref graph i) (cons dep (vector-ref (vector-ref graph i))))
      (vector-set! in-degree dep (+ 1 (vector-ref in-degree dep)))))

  (define (top-sort graph in-degree)
    (define result '())
    (define queue (make-queue))
    (for ([i (in-range (vector-length in-degree))] #:when (= (vector-ref in-degree i) 0))
      (enqueue queue i))

    (while (not (empty? queue))
      (define node (dequeue queue))
      (set! result (cons node result))
      (for ([neighbor (in-list (vector-ref graph node))])
        (vector-set! in-degree neighbor (- (vector-ref in-degree neighbor) 1))
        (when (= (vector-ref in-degree neighbor) 0)
          (enqueue queue neighbor))))

    (if (= (length result) (vector-length in-degree))
        (reverse result)
        '()))

  (define item-order (top-sort graph in-degree))
  (if (null? item-order) '() 
      (define group-order (top-sort group-graph group-in-degree))
      (if (null? group-order) '() 
          (apply append (map (lambda (g) (filter (lambda (x) (= (vector-ref group x) g)) item-order)) group-order))))))

(sortItems n m group items)