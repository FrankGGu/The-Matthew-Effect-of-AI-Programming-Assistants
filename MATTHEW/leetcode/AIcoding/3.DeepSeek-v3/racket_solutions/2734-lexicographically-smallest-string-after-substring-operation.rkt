(define (smallest-string s)
  (let loop ((i 0) (changed #f) (result (list)))
    (cond
      [(= i (string-length s))
       (if changed
           (list->string (reverse result))
           (let ((new-s (string-copy s)))
             (string-set! new-s (- (string-length new-s) 1) #\a)
             new-s))]
      [(and (not changed) (char>? (string-ref s i) #\a))
       (loop (+ i 1) #t (cons #\a (append (reverse (string->list (substring s 0 i))) result)))]
      [else
       (loop (+ i 1) changed (cons (string-ref s i) result))])))