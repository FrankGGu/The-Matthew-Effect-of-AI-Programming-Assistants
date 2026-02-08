(define (jump nums)
  (let* ((n (vector-length nums)))
    (cond
      ((= n 1) 0)
      (else
       (let loop ((i 0)
                  (jumps 0)
                  (current-end 0)
                  (farthest 0))
         (cond
           ((= i (- n 1))
            jumps)
           (else
            (let* ((num-at-i (vector-ref nums i))
                   (new-farthest (max farthest (+ i num-at-i))))
              (if (= i current-end)
                  (loop (+ i 1)
                        (+ jumps 1)
                        new-farthest
                        new-farthest)
                  (loop (+ i 1)
                        jumps
                        current-end
                        new-farthest)))))))))