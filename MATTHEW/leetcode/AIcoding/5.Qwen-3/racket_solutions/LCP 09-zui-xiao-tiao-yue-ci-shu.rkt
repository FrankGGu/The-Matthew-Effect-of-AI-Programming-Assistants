(define (jump nums)
  (define (helper i steps farthest)
    (if (>= i (length nums))
        steps
        (let ((new-farthest (max farthest (+ i (list-ref nums i)))))
          (if (= new-farthest i)
              (helper (+ i 1) steps new-farthest)
              (helper (+ i 1) (+ steps 1) new-farthest)))))
  (helper 0 0 0))