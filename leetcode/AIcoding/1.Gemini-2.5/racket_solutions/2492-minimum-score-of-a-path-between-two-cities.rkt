(define (min-score-path n roads)
  (define graph (make-hash))
  (for-each
   (lambda (road)
     (define u (car road))
     (define v (cadr road))
     (define dist (caddr road))
     (hash-update! graph u (lambda (lst) (cons (list v dist) lst)) '())
     (hash-update! graph v (lambda (lst) (cons (list u dist) lst)) '()))
   roads)

  (define visited (make-hash))

  (define q-front (list 1))
  (define q-back '())

  (hash-set! visited 1 #t)

  (define (dequeue)
    (cond
      ((not (empty? q-front))
       (define item (car q-front))
       (set! q-front (cdr q-front))
       item)
      ((not (empty? q-back))
       (set! q-front (reverse q-back))
       (set! q-back '())
       (dequeue))
      (else #f)))

  (define (enqueue item)
    (set! q-back (cons item q-back)))

  (define (queue-empty?)
    (and (empty? q-front) (empty? q-back)))

  (define (bfs-loop)
    (unless (queue-empty?)
      (define u (dequeue))

      (define neighbors (hash-ref graph u '()))
      (for-each
       (lambda (neighbor-info)
         (define v (car neighbor-info))
         (when (not (hash-ref visited v #f))
           (hash-set! visited v #t)
           (enqueue v)))
       neighbors)
      (bfs-loop)))

  (bfs-loop)

  (define min-dist +inf.0)

  (for-each
   (lambda (road)
     (define u (car road))
     (define v (cadr road))
     (define dist (caddr road))
     (when (and (hash-ref visited u #f) (hash-ref visited v #f))
       (set! min-dist (min min-dist dist))))
   roads)

  min-dist)