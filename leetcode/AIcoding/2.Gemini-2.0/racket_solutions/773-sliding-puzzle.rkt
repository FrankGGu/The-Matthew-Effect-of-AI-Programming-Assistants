(define (slidingPuzzle board)
  (define target "123450")
  (define (board->string b)
    (string-append
     (number->string (list-ref (list-ref b 0) 0))
     (number->string (list-ref (list-ref b 0) 1))
     (number->string (list-ref (list-ref b 0) 2))
     (number->string (list-ref (list-ref b 1) 0))
     (number->string (list-ref (list-ref b 1) 1))
     (number->string (list-ref (list-ref b 1) 2))))

  (define (string->board s)
    (list (list (string->number (substring s 0 1)) (string->number (substring s 1 2)) (string->number (substring s 2 3)))
          (list (string->number (substring s 3 4)) (string->number (substring s 4 5)) (string->number (substring s 5 6)))))

  (define (get-neighbors s)
    (define zero-index (string-index s #\0))
    (define neighbors
      (cond
        ((= zero-index 0) (list (string-replace s 0 1 (substring s 1 2)) (string-replace s 0 1 (substring s 3 4))))
        ((= zero-index 1) (list (string-replace s 1 2 (substring s 0 1)) (string-replace s 1 2 (substring s 2 3)) (string-replace s 1 2 (substring s 4 5))))
        ((= zero-index 2) (list (string-replace s 2 3 (substring s 1 2)) (string-replace s 2 3 (substring s 5 6))))
        ((= zero-index 3) (list (string-replace s 3 4 (substring s 0 1)) (string-replace s 3 4 (substring s 4 5))))
        ((= zero-index 4) (list (string-replace s 4 5 (substring s 1 2)) (string-replace s 4 5 (substring s 3 4)) (string-replace s 4 5 (substring s 5 6))))
        ((= zero-index 5) (list (string-replace s 5 6 (substring s 2 3)) (string-replace s 5 6 (substring s 4 5))))))
    neighbors)

  (define initial-state (board->string board))
  (define visited (make-hash))
  (hash-set! visited initial-state #t)
  (define queue (list (cons initial-state 0)))

  (let loop ((q queue))
    (cond
      ((null? q) -1)
      (else
       (define current-state (car (car q)))
       (define current-moves (cdr (car q)))
       (if (string=? current-state target)
           current-moves
           (let ((neighbors (get-neighbors current-state)))
             (let ((new-queue
                    (append (cdr q)
                            (filter
                             (lambda (neighbor)
                               (if (hash-has-key? visited neighbor)
                                   #f
                                   (begin
                                     (hash-set! visited neighbor #t)
                                     #t)))
                             neighbors))))
               (loop (map (lambda (x) (cons x (+ current-moves 1))) new-queue))))))))