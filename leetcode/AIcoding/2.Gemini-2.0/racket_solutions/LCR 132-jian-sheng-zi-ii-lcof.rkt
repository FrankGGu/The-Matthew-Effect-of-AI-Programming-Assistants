(define (chop-sticks sticks)
  (let ((n (length sticks)))
    (if (<= n 2)
        0
        (let loop ((sticks (sort sticks <))
                   (ops 0))
          (if (and (= (car sticks) (last sticks)))
              ops
              (let* ((max-val (last sticks))
                     (new-max (ceiling (/ max-val 2))))
                (if (and (= new-max (car sticks)) (= (length (remove-duplicates sticks)) 2))
                    (+ ops n)
                    (loop (sort (append (drop-right sticks 1) (list new-max)) <) (+ ops n)))))))))