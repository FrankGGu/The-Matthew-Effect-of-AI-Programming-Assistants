(define (insert intervals new-interval)
  (let* ((new-start (car new-interval))
         (new-end (cadr new-interval))
         (merged '())
         (i 0)
         (len (length intervals)))
    (cond
      ((null? intervals) (list new-interval))
      (else
       (let loop ((i 0) (intervals intervals))
         (cond
           ((= i len)
            (append merged (list new-interval)))
           ((< (cadr (car intervals)) new-start)
            (loop (+ i 1) (cdr intervals) (set! merged (append merged (list (car intervals))))))
           ((> (car (car intervals)) new-end)
            (append merged (cons new-interval intervals)))
           (else
            (let ((start (min new-start (car (car intervals))))
                  (end (max new-end (cadr (car intervals)))))
              (let next-interval-loop ((intervals (cdr intervals)) (i (+ i 1)))
                (cond
                  ((= i len) (append merged (list (list start end))))
                  ((> (car (car intervals)) new-end)
                   (append merged (cons (list start end) intervals)))
                  ((< (cadr (car intervals)) new-start)
                    (loop (+ i 1) (cdr intervals) (set! merged (append merged (list (car intervals))))))
                  (else
                   (set! end (max end (cadr (car intervals))))
                   (next-interval-loop (cdr intervals) (+ i 1))))))))))))))