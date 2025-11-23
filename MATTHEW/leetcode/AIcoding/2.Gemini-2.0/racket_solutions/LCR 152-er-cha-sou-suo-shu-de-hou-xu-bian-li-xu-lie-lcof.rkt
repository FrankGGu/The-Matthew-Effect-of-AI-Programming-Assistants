(define (verify-postorder postorder)
  (define (helper postorder start end)
    (cond
      [(<= (- end start) 0) #t]
      [else
       (let* ([root-val (list-ref postorder (- end 1))]
              [i start])
         (begin
           (while (and (< i (- end 1)) (< (list-ref postorder i) root-val))
             (set! i (+ i 1)))
           (let loop ([j i])
             (cond
               [(>= j (- end 1))
                (and (helper postorder start i) (helper postorder i (- end 1)))]
               [(> (list-ref postorder j) root-val)
                (loop (+ j 1))]
               [else #f]))))]))
  (helper postorder 0 (length postorder)))