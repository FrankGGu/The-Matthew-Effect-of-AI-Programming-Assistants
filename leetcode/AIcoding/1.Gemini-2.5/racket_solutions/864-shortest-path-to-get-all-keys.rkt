#lang racket

(require data/queue)
(require data/set)

(define (shortest-path-all-keys grid)
  (define rows (length grid))
  (define cols (string-length (car grid)))

  (define char-grid (map string->list grid))

  (define start-r 0)
  (define start-c 0)
  (define actual-all-keys-mask 0)

  ;; Find start position and compute the mask for all keys present in the grid
  (define all-keys-present (make-hash))
  (for* ([r (in-range rows)]
         [c (in-range cols)])
    (define cell (list-ref (list-ref char-grid r) c))
    (cond
      [(char=? cell #\@)
       (set! start-r r)
       (set! start-c c)]
      [(and (char>=? cell #\a) (char<=? cell #\f))
       (hash-set! all-keys-present cell #t)]))

  ;; Construct the target mask representing all keys collected
  (for-each (lambda (k-char)
              (set! actual-all-keys-mask
                    (bitwise-ior actual-all-keys-mask
                                 (expt 2 (- (char->integer k-char) (char->integer #\a))))))
            (hash-keys all-keys-present))

  (define q (make-queue))
  (define visited (make-set)) ; Stores (list r c keys-mask)

  ;; Initial state: (r c keys-mask steps)
  (queue-add! q (list start-r start-c 0 0))
  (set-add! visited (list start-r start-c 0))

  (define directions '((0 1) (0 -1) (1 0) (-1 0)))

  (define (bfs-loop)
    (if (queue-empty? q)
        -1 ; No path found
        (let* ([current-state (queue-remove! q)]
               [current-r (list-ref current-state 0)]
               [current-c (list-ref current-state 1)]
               [current-keys-mask (list-ref current-state 2)]
               [current-steps (list-ref current-state 3)])

          (if (= current-keys-mask actual-all-keys-mask)
              current-steps ; Found all keys, return steps
              (begin
                (for-each (lambda (dir)
                            (define dr (list-ref dir 0))
                            (define dc (list-ref dir 1))
                            (define nr (+ current-r dr))
                            (define nc (+ current-c dc))

                            (when (and (>= nr 0) (< nr rows)
                                       (>= nc 0) (< nc cols))
                              (define next-cell (list-ref (list-ref char-grid nr) nc))
                              (define new-keys-mask current-keys-mask)
                              (define can-move #f)

                              (cond
                                [(char=? next-cell #\#) ; Wall
                                 (set! can-move #f)]
                                [(char=? next-cell #\.) ; Empty
                                 (set! can-move #t)]
                                [(char=? next-cell #\@) ; Start
                                 (set! can-move #t)]
                                [(and (char>=? next-cell #\a) (char<=? next-cell #\f)) ; Key
                                 (set! new-keys-mask
                                       (bitwise-ior current-keys-mask
                                                    (expt 2 (- (char->integer next-cell) (char->integer #\a)))))
                                 (set! can-move #t)]
                                [(and (char>=? next-cell #\A) (char<=? next-cell #\F)) ; Lock
                                 (define lock-bit (expt 2 (- (char->integer (char-downcase next-cell)) (char->integer #\a))))
                                 (when (not (zero? (bitwise-and current-keys-mask lock-bit)))
                                   (set! can-move #t))])

                              (when can-move
                                (define next-state-tuple (list nr nc new-keys-mask))
                                (when (not (set-contains? visited next-state-tuple))
                                  (set-add! visited next-state-tuple)
                                  (queue-add! q (list nr nc new-keys-mask (add1 current-steps))))))))
                (bfs-loop)))))) ; Continue the loop

  (bfs-loop)) ; Start the BFS