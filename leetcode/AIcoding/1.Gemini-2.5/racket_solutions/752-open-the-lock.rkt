#lang racket

(require racket/hash)
(require racket/queue)

(define (openLock deadends target)
  (define deadends-set (make-hash))
  (for-each (lambda (s) (hash-set! deadends-set s #t)) deadends)

  (if (hash-has-key? deadends-set "0000")
      -1
      (let ()
        (define visited (make-hash))
        (define q (make-queue))

        (queue-put! q (cons "0000" 0))
        (hash-set! visited "0000" #t)

        (let bfs-loop ()
          (if (queue-empty? q)
              -1
              (let* ((current-pair (queue-get! q))
                     (combo (car current-pair))
                     (steps (cdr current-pair)))

                (if (string=? combo target)
                    steps
                    (begin
                      (for ([i (in-range 4)])
                        (let* ((digit-char (string-ref combo i))
                               (digit-val (- (char->integer digit-char) (char->integer #\0))))

                          (let* ((next-digit-val (remainder (+ digit-val 1) 10))
                                 (next-digit-char (integer->char (+ next-digit-val (char->integer #\0))))
                                 (up-combo (string-set combo i next-digit-char)))
                            (unless (or (hash-has-key? visited up-combo)
                                        (hash-has-key? deadends-set up-combo))
                              (hash-set! visited up-combo #t)
                              (queue-put! q (cons up-combo (+ steps 1)))))

                          (let* ((next-digit-val (remainder (+ digit-val 9) 10))
                                 (next-digit-char (integer->char (+ next-digit-val (char->integer #\0))))
                                 (down-combo (string-set combo i next-digit-char)))
                            (unless (or (hash-has-key? visited down-combo)
                                        (hash-has-key? deadends-set down-combo))
                              (hash-set! visited down-combo #t)
                              (queue-put! q (cons down-combo (+ steps 1)))))))
                      (bfs-loop))))))))