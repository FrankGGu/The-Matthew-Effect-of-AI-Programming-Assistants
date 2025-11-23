(require data/queue)

(define (minimum-jumps forbidden a b x)
  (define actual-max-pos 8000) ; A sufficiently large upper bound for positions to explore.
                               ; Based on constraints (x, a, b <= 2000), x + 2*b or x + a + b
                               ; often suffice, which is around 6000. 8000 provides a safe margin.

  (define forbidden-set (make-hash))
  (for-each (lambda (pos) (hash-set! forbidden-set pos #t)) forbidden)

  ; visited[pos][0] indicates if (pos, last_jump_was_forward) has been visited.
  ; visited[pos][1] indicates if (pos, last_jump_was_backward) has been visited.
  (define visited (make-vector (+ actual-max-pos 1) #f))
  (for ([i (in-range (+ actual-max-pos 1))])
    (vector-set! visited i (vector #f #f))) ; Each element is a vector of two booleans

  (define q (make-queue))
  ; Queue elements: (position, jumps, last-jump-was-backward?)
  (queue-enqueue! q (list 0 0 #f))

  ; Mark initial state (0, not_backward_jump) as visited
  (vector-set! (vector-ref visited 0) 0 #t)

  (let loop ()
    (if (queue-empty? q)
        -1 ; Target not reachable
        (let* ([current (queue-dequeue! q)]
               [pos (list-ref current 0)]
               [jumps (list-ref current 1)]
               [was-backward (list-ref current 2)])

          (when (= pos x)
            (error 'found-x jumps)) ; Use error to break out and return the number of jumps

          ; Jump forward
          (let ([next-pos-f (+ pos a)])
            (when (and (<= next-pos-f actual-max-pos)
                       (not (hash-ref forbidden-set next-pos-f #f)) ; Not a forbidden position
                       (not (vector-ref (vector-ref visited next-pos-f) 0))) ; Not visited with forward jump
              (vector-set! (vector-ref visited next-pos-f) 0 #t)
              (queue-enqueue! q (list next-pos-f (+ jumps 1) #f))))

          ; Jump backward
          (let ([next-pos-b (- pos b)])
            (when (and (not was-backward) ; Cannot jump backward twice in a row
                       (>= next-pos-b 0) ; Cannot jump to a negative position
                       (not (hash-ref forbidden-set next-pos-b #f)) ; Not a forbidden position
                       (not (vector-ref (vector-ref visited next-pos-b) 1))) ; Not visited with backward jump
              (vector-set! (vector-ref visited next-pos-b) 1 #t)
              (queue-enqueue! q (list next-pos-b (+ jumps 1) #t))))
          (loop))))
  ; Catch the error thrown when x is found and return its value
  (with-handlers
      ([exn:fail:user?
        (lambda (e)
          (if (string=? (exn-message e) "found-x")
              (exn-continuation-arg e) ; Return the jumps value
              (error e)))]) ; Re-raise other errors
    (loop)))