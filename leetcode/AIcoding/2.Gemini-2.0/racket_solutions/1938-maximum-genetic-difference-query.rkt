(define (maximum-genetic-difference querys nums)
  (let* ((n (length nums))
         (root -1)
         (adj (make-vector n '()))
         (result (make-vector (length querys) 0)))
    (for/list ((i (in-range n)))
      (if (= (vector-ref nums i) -1)
          (set! root i)
          (set! (vector-ref adj (vector-ref nums i)) (cons i (vector-ref adj (vector-ref nums i))))))

    (define (max-xor num arr)
      (if (null? arr)
          0
          (apply max (map (lambda (x) (bitwise-xor num x)) arr))))

    (define (dfs node current-path)
      (for/list ((i (in-range (length querys))))
        (let ((query (list-ref querys i)))
          (if (= (car query) node)
              (vector-set! result i (max-xor (cadr query) current-path)))))

      (let loop ((neighbors (vector-ref adj node)))
        (when (not (null? neighbors))
          (let ((neighbor (car neighbors)))
            (dfs neighbor (cons neighbor current-path))
            (loop (cdr neighbors))))))

    (dfs root '())
    (vector->list result)))