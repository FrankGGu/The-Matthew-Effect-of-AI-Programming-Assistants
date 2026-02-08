(require racket/hash)
(require racket/queue)

(define (openLock deadends target)
  (let/ec return-value
    (define deadends-set (make-hash))
    (for-each (lambda (s) (hash-set! deadends-set s #t)) deadends)

    (when (hash-has-key? deadends-set "0000")
      (return-value -1))

    (define (get-next-states s)
      (define (rotate-char c direction)
        (let* ((val (- (char->integer c) (char->integer #\0)))
               (new-val (modulo (+ val direction 10) 10)))
          (integer->char (+ new-val (char->integer #\0)))))

      (for/list ([i (in-range 4)]
                 [direction '(-1 1)])
        (list->string
         (for/list ([j (in-range 4)])
           (if (= i j)
               (rotate-char (string-ref s j) direction)
               (string-ref s j))))))

    (define q (make-queue))
    (define visited-set (make-hash))

    (queue-enqueue! q (cons "0000" 0))
    (hash-set! visited-set "0000" #t)

    (let bfs-loop ()
      (when (not (queue-empty? q))
        (let* ((current-pair (queue-dequeue! q))
               (current-combo (car current-pair))
               (turns (cdr current-pair)))

          (when (string=? current-combo target)
            (return-value turns))

          (for-each (lambda (next-combo)
                      (when (and (not (hash-has-key? visited-set next-combo))
                                 (not (hash-has-key? deadends-set next-combo)))
                        (hash-set! visited-set next-combo #t)
                        (queue-enqueue! q (cons next-combo (+ turns 1)))))
                    (get-next-states current-combo))
          (bfs-loop))))
    -1))