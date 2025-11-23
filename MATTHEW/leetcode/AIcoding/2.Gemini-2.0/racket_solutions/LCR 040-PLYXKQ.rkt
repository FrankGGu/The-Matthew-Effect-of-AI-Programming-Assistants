(define (largest-rectangle-area heights)
  (let loop ((stack '()) (max-area 0) (i 0))
    (cond
      [(or (= i (length heights)) (and (not (empty? stack)) (> (list-ref heights i) (list-ref heights (car stack)))))
       (let ((current-height (if (= i (length heights)) 0 (list-ref heights i))))
         (cond
           [(or (empty? stack) (>= current-height (list-ref heights (car stack))))
            (loop (cons i stack) max-area (+ i 1))]
           [else
            (let ((top (car stack)) (new-stack (cdr stack)))
              (let ((area (* (list-ref heights top) (if (empty? new-stack) i (- i (car new-stack) 1)))))
                (loop new-stack (max max-area area) i))))])]
      [else max-area])))

(define (maximal-rectangle matrix)
  (if (empty? matrix)
      0
      (let ((rows (length matrix)) (cols (length (car matrix))))
        (let loop ((row 0) (max-area 0) (heights (make-list cols 0)))
          (if (= row rows)
              max-area
              (let ((new-heights (map (lambda (h c) (if (equal? c #\1) (+ h 1) 0)) heights (list-ref matrix row))))
                (loop (+ row 1) (max max-area (largest-rectangle-area new-heights)) new-heights))))))))