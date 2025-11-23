(define (closest-node edges node1 node2)
  (define (find-path start)
    (let loop ((current start) (visited '()))
      (if (or (null? current) (member current visited))
          '()
          (cons current (loop (list-ref edges current) (cons current visited))))))

  (define path1 (find-path node1))
  (define path2 (find-path node2))

  (define common-nodes (intersection path1 path2))

  (if (null? common-nodes)
      -1
      (apply max common-nodes)))

(define (intersection lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))