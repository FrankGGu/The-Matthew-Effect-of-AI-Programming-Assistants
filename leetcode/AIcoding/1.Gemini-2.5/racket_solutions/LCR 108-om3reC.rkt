#lang racket

(require racket/set)
(require racket/queue)
(require racket/hash)
(require racket/list)

(define (ladder-length begin-word end-word word-list)
  (define word-set (list->hash-set word-list))

  (unless (hash-set-member? word-set end-word)
    0)

  (let/ec return-from-ladder-length
    (define q (make-queue))
    (enqueue! q (list begin-word 1))

    (define visited (make-hash-set))
    (hash-set-add! visited begin-word)

    (define alphabet (string->list "abcdefghijklmnopqrstuvwxyz"))

    (let bfs-loop ()
      (cond
        ((queue-empty? q)
         0)
        (else
         (define current-item (dequeue! q))
         (define current-word (first current-item))
         (define current-level (second current-item))

         (when (string=? current-word end-word)
           (return-from-ladder-length current-level))

         (define word-len (string-length current-word))
         (define current-word-chars (string->list current-word))

         (for ([i (in-range word-len)])
           (define original-char (list-ref current-word-chars i))
           (for ([char alphabet])
             (when (char-not-equal? char original-char)
               (define next-word-chars (list-set current-word-chars i char))
               (define next-word (list->string next-word-chars))

               (when (and (hash-set-member? word-set next-word)
                          (not (hash-set-member? visited next-word)))
                 (hash-set-add! visited next-word)
                 (enqueue! q (list next-word (+ current-level 1)))))))
         (bfs-loop))))))