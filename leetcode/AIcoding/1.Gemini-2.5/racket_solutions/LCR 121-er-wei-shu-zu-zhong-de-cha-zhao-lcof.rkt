(define (search-matrix matrix target)
  (let* ((rows (length matrix))
         (cols (if (empty? matrix) 0 (length (car matrix)))))
    (if (or (= rows 0) (= cols 0))
        #false
        (let loop ((r 0) (c (- cols 1)))
          (cond
            ((or (>= r rows) (< c 0)) #false)
            (else
             (let ((current-val (list-ref (list-ref matrix r) c)))
               (cond
                 ((= current-val target) #true)
                 ((< current-val target) (loop (+ r 1) c))
                 (else (loop r (- c 1))))))))))