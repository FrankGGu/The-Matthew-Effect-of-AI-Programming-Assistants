(define (maximum-white-tiles carpetLength carpetWidth tiles)
  (define (count-tiles length tiles)
    (let loop ((tiles tiles) (length length) (count 0))
      (cond
        ((null? tiles) count)
        ((> (car (car tiles)) length) count)
        (else (loop (cdr tiles) (- length (car (car tiles))) (+ count 1))))))

  (define (helper tiles start end count)
    (if (>= start (length tiles))
        count
        (let ((next-start (car (list-ref tiles start)))
              (next-end (if (< start (sub1 (length tiles)))
                            (car (list-ref tiles (add1 start)))
                            (+ (car (list-ref tiles start)) carpetWidth))))
          (let ((cover (count-tiles carpetWidth (sublist tiles start (length tiles)))))
            (max count 
                 (if (< next-start next-end)
                     (helper tiles (add1 start) end (+ cover (if (< start (sub1 (length tiles))) (car (list-ref tiles (add1 start))) 0)))
                     (helper tiles (add1 start) end count)))))))

  (let* ((sorted-tiles (sort tiles (lambda (a b) (< (car a) (car b)))))
         (total-length (foldl (lambda (tile acc) (+ acc (- (cadr tile) (car tile)))) 0 sorted-tiles)))
    (helper sorted-tiles 0 (length sorted-tiles) total-length)))