(define (max-value events k)
  (define n (length events))
  (define sorted-events (sort events (lambda (x y) (< (car x) (car y)))))

  (define memo (make-hash))

  (define (dp index count)
    (if (or (= index n) (= count k))
        0
        (let ((key (cons index count)))
          (if (hash-has-key? memo key)
              (hash-ref memo key)
              (let* ((current-event (list-ref sorted-events index))
                     (start-time (car current-event))
                     (end-time (cadr current-event))
                     (value (caddr current-event))
                     (next-index (let loop ((i (+ index 1)))
                                     (if (= i n)
                                         n
                                         (if (<= start-time (car (list-ref sorted-events i)))
                                             (let next-event (list-ref sorted-events i))
                                               (if (> (car next-event) end-time)
                                                   i
                                                   (loop (+ i 1)))
                                             )
                                             i))))
                     (attend-value (+ value (dp next-index (+ count 1))))
                     (skip-value (dp (+ index 1) count))
                     (result (max attend-value skip-value)))
                 (hash-set! memo key result)
                 result)))))

  (dp 0 0))