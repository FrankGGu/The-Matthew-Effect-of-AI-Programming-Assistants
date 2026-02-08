(define (num-moves x y z)
  (let* ((positions (sort (list x y z) <))
         (a (car positions))
         (b (cadr positions))
         (c (caddr positions)))
    (let ((min-m
           (cond
             ((= (- c a) 2) 0)
             ((or (<= (- b a) 2) (<= (- c b) 2)) 1)
             (else 2)))
          (max-m
           (+ (- b a 1) (- c b 1))))
      (list min-m max-m))))