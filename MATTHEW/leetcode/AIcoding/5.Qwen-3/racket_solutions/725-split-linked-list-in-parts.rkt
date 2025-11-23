(define (split-list-in-parts head k)
  (define (length-of-list node)
    (if (not node)
        0
        (+ 1 (length-of-list (cdr node)))))

  (define (create-node val)
    (cons val '()))

  (define (append-node lst node)
    (if (null? lst)
        (list node)
        (append lst (list node))))

  (define (split-helper node parts count)
    (if (or (null? node) (zero? count))
        parts
        (let* ((part-size (quotient (length-of-list node) count))
               (remainder (modulo (length-of-list node) count)))
          (let loop ((current node) (current-part '()) (remaining count) (extra 0))
            (if (or (null? current) (zero? remaining))
                (append-node parts (reverse current-part))
                (let ((new-current (cdr current)))
                  (if (and (>= extra 0) (= (remainder (length-of-list new-current) remaining) 0))
                      (loop new-current (cons current current-part) (- remaining 1) (- extra 1))
                      (loop new-current (cons current current-part) remaining (- extra 1))))))))

  (if (null? head)
      (make-list k '())
      (split-helper head '() k)))