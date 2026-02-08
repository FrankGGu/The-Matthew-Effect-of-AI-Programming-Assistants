(define (smallestLexicographical array allowed-Swaps)
  (let* ((n (length array))
         (parent (vector-immutable-copy (list->vector (range n))))
         (size (vector-immutable-copy (make-vector n 1))))

    (define (find i)
      (if (equal? i (vector-ref parent i))
          i
          (let ((root (find (vector-ref parent i))))
            (vector-set! parent i root)
            root)))

    (define (union i j)
      (let* ((root-i (find i))
             (root-j (find j)))
        (unless (equal? root-i root-j)
          (if (< (vector-ref size root-i) (vector-ref size root-j))
              (begin
                (vector-set! parent root-i root-j)
                (vector-set! size root-j (+ (vector-ref size root-j) (vector-ref size root-i))))
              (begin
                (vector-set! parent root-j root-i)
                (vector-set! size root-i (+ (vector-ref size root-i) (vector-ref size root-j))))))))

    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (when (<= (abs (- i j)) allowed-Swaps)
          (union i j))))

    (let* ((groups (make-hash))
           (result (vector-immutable-copy array)))

      (for ([i (in-range n)])
        (let ((root (find i)))
          (if (hash-has-key? groups root)
              (hash-update! groups root cons i)
              (hash-set! groups root (list i)))))

      (hash-for-each groups
                     (lambda (root indices)
                       (let* ((sorted-indices (sort indices <))
                              (values (map (lambda (i) (vector-ref array i)) sorted-indices))
                              (sorted-values (sort values <)))
                         (for ([i (in-range (length sorted-indices))])
                           (vector-set! result (list-ref sorted-indices i) (list-ref sorted-values i))))))
      (vector->immutable-vector result))))