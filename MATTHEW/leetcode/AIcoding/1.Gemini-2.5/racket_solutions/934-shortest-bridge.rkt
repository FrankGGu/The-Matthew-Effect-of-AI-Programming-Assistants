#lang racket

(require data/queue)

(define (shortest-bridge grid)
  (define R (length grid))
  (define C (length (car grid)))

  (define (valid? r c)
    (and (>= r 0) (< r R) (>= c 0) (< c C)))

  (define dirs '((0 1) (0 -1) (1 0) (-1 0)))

  (define q (make-queue))
  (define visited (make-hash))

  (define found-first-island #f)
  (for* ([r (in-range R)]
         [c (in-range C)]
         #:when (not found-first-island))
    (when (= (list-ref (list-ref grid r) c) 1)
      (set! found-first-island #t)
      (define (dfs r c)
        (when (and (valid? r c)
                   (= (list-ref (list-ref grid r) c) 1)
                   (not (hash-has-key? visited (list r c))))
          (hash-set! visited (list r c) #t)
          (enqueue! q (list r c))
          (for-each (lambda (dir)
                      (define dr (car dir))
                      (define dc (cadr dir))
                      (dfs (+ r dr) (+ c dc)))
                    dirs)))
      (dfs r c)))

  (define dist 0)
  (with-handlers ([exn:fail:user?
                   (lambda (e)
                     (if (string=? (exn-message e) "found-second-island")
                         (exn-continuation-arg e)
                         (raise e)))])
    (let loop ()
      (define level-size (queue-size q))
      (when (> level-size 0)
        (for ([_ (in-range level-size)])
          (define current-cell (dequeue! q))
          (define r (car current-cell))
          (define c (cadr current-cell))

          (for-each (lambda (dir)
                      (define dr (car dir))
                      (define dc (cadr dir))
                      (define nr (+ r dr))
                      (define nc (+ c dc))
                      (when (and (valid? nr nc)
                                 (not (hash-has-key? visited (list nr nc))))
                        (cond
                          [(= (list-ref (list-ref grid nr) nc) 1)
                           (error 'found-second-island dist)]
                          [(= (list-ref (list-ref grid nr) nc) 0)
                           (hash-set! visited (list nr nc) #t)
                           (enqueue! q (list nr nc))]))))
        (set! dist (+ dist 1))
        (loop))))
  )