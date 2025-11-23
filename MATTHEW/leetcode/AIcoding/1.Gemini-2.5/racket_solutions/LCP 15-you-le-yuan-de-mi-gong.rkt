(require data/queue)

(define (has-path maze start destination)
  (define rows (length maze))
  (define cols (length (car maze)))

  (define (get-cell r c)
    (list-ref (list-ref maze r) c))

  (define visited (make-vector rows))
  (for ([i (in-range rows)])
    (vector-set! visited i (make-vector cols #f)))

  (define q (make-queue))
  (enqueue! q start)
  (vector-set! (vector-ref visited (car start)) (cadr start) #t)

  (define (is-valid r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (roll r c dr dc)
    (let loop ((curr-r r) (curr-c c))
      (define next-r (+ curr-r dr))
      (define next-c (+ curr-c dc))
      (if (and (is-valid next-r next-c)
               (= (get-cell next-r next-c) 0))
          (loop next-r next-c)
          (list curr-r curr-c))))

  (let loop ()
    (if (queue-empty? q)
        #f
        (let* ((curr-pos (dequeue! q))
               (r (car curr-pos))
               (c (cadr curr-pos)))
          (if (and (= r (car destination)) (= c (cadr destination)))
              #t
              (begin
                (for ([dr '(-1 1 0 0)] [dc '(0 0 -1 1)])
                  (let* ((next-stop (roll r c dr dc))
                         (nr (car next-stop))
                         (nc (cadr next-stop)))
                    (when (not (vector-ref (vector-ref visited nr) nc))
                      (vector-set! (vector-ref visited nr) nc #t)
                      (enqueue! q next-stop))))
                (loop)))))))