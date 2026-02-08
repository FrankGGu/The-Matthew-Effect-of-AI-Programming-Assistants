(define (swapNodes head k)
  (define (get-length node)
    (if (null? node)
        0
        (+ 1 (get-length (cdr node)))))

  (define len (get-length head))
  (define first-node (let loop ([node head] [i 1])
                       (if (= i k)
                           node
                           (loop (cdr node) (+ i 1)))))
  (define second-node (let loop ([node head] [i 1])
                        (if (= i (- len k -1))
                            node
                            (loop (cdr node) (+ i 1)))))

  (define (swap node1 node2)
    (if (equal? node1 node2)
        head
        (let* ((temp (cdr node1))
               (temp2 (cdr node2))
               (new-node1 (cons (car node2) temp))
               (new-node2 (cons (car node1) temp2)))
          (if (null? (cdr node1))
              (cons (car new-node2) (cdr new-node2))
              (cons (car new-node1) (cons (car new-node2) (cdr temp))))))
  (swap first-node second-node))