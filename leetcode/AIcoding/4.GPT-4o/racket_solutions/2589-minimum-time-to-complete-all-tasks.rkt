(define (minimumTimeRequired tasks workers)
  (define (canFinishInTime time)
    (define (helper tasks remaining-workers)
      (if (null? tasks)
          #t
          (let loop ((task (car tasks)) (rest (cdr tasks)) (workers remaining-workers))
            (cond
              ((null? workers) #f)
              ((<= task time)
               (or (loop rest (cdr workers))
                   (and (helper rest (cdr workers))
                        (loop rest (cons (car workers) (cdr workers))))))
              (else (loop rest (cdr workers))))))
    (helper (sort tasks >) (sort workers >)))

  (define (binarySearch left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (canFinishInTime mid)
              (binarySearch left mid)
              (binarySearch (add1 mid) right)))))

  (binarySearch 0 (apply max tasks))
)

(minimumTimeRequired (vector 3 2 3) (vector 3 3 2))