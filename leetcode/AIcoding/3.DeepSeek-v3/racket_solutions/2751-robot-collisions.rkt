(define (survivingRobots positions healths directions)
  (define robots (sort (for/list ([pos positions] [h healths] [d directions])
                         (list pos h (if (char=? d #\R) 'right 'left)))
                       (lambda (a b) (< (car a) (car b)))))

  (define (collide stack robot)
    (let* ([top (car stack)]
           [top-pos (car top)]
           [top-h (cadr top)]
           [top-dir (caddr top)]
           [robot-pos (car robot)]
           [robot-h (cadr robot)]
           [robot-dir (caddr robot)])
      (cond
        [(and (eq? top-dir 'right) (eq? robot-dir 'left))
         (cond
           [(> top-h robot-h)
            (cons (list top-pos (- top-h robot-h) top-dir) (cdr stack))]
           [(< top-h robot-h)
            (cons (list robot-pos (- robot-h top-h) robot-dir) (cdr stack))]
           [else (cdr stack)])]
        [else (cons robot stack)])))

  (define (process-robots robots)
    (let loop ([stack '()]
               [remaining robots])
      (if (null? remaining)
          (reverse stack)
          (let ([robot (car remaining)]
                [rest (cdr remaining)])
            (if (null? stack)
                (loop (cons robot stack) rest)
                (loop (collide stack robot) rest))))))

  (define result (process-robots robots))
  (define indices (make-hash))
  (for ([i (in-range (length positions))])
    (hash-set! indices (list-ref positions i) i))

  (define output (make-vector (length positions) 0))
  (for ([robot result])
    (let ([pos (car robot)]
          [h (cadr robot)])
      (vector-set! output (hash-ref indices pos) h)))
  (filter (lambda (x) (not (zero? x))) (vector->list output)))