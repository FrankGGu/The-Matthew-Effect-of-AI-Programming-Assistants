(define (rotating-box m)
  (define (rotate-row row)
    (let loop ((i (- (length row) 1))
               (j 0)
               (result '()))
      (if (> i j)
          (reverse result)
          (loop (- i 1)
                (+ j 1)
                (cons (list-ref row i) result)))))

  (define (process-row row)
    (let loop ((i 0)
               (j 0)
               (result '())
               (count 0))
      (cond ((= i (length row))
             (append (make-list count #\*)
                     (reverse result)))
            ((char=? (list-ref row i) #\#)
             (loop (+ i 1)
                   j
                   (cons #\# result)
                   count))
            ((char=? (list-ref row i) #\*)
             (loop (+ i 1)
                   j
                   result
                   (+ count 1)))
            (else
             (loop (+ i 1)
                   j
                   result
                   count)))))

  (define (rotate-box box)
    (let* ((rows (length box))
           (cols (length (car box)))
           (new-box (make-vector cols (make-vector rows #\space))))
      (for-each
       (lambda (i)
         (for-each
          (lambda (j)
            (vector-set! new-box j i (vector-ref box i j)))
          (range cols)))
       (range rows))
      (map (lambda (row) (list->string row)) (vector->list new-box))))

  (define (solve box)
    (let ((processed-box (map process-row box)))
      (rotate-box processed-box)))

  (solve m))