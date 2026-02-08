(define (can-place? positions m force)
  (let loop ((count 1)
             (last-pos (car positions))
             (remaining-positions (cdr positions)))
    (cond
      ((= count m) #t)
      ((null? remaining-positions) #f)
      (else
       (let ((current-pos (car remaining-positions)))
         (if (>= (- current-pos last-pos) force)
             (loop (+ count 1)
                   current-pos
                   (cdr remaining-positions))
             (loop count
                   last-pos
                   (cdr remaining-positions))))))))

(define (max-force positions m)
  (let* ((sorted-positions (sort positions <))
         (n (length sorted-positions))
         (low 1)
         (high (- (list-ref sorted-positions (- n 1)) (list-ref sorted-positions 0))))
    (let loop ((l low) (h high) (ans 0))
      (if (> l h)
          ans
          (let ((mid (+ l (quotient (- h l) 2))))
            (if (can-place? sorted-positions m mid)
                (loop (+ mid 1) h mid)
                (loop l (- mid 1) ans)))))))