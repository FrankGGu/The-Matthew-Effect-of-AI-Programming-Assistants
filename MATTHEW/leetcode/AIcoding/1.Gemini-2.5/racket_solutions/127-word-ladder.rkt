#lang racket

(require racket/queue)
(require racket/set)

(define (ladderLength beginWord endWord wordList)
  (define word-set (list->set wordList))

  (if (not (set-member? word-set endWord))
      0
      (begin
        (define q (make-queue))
        (define visited (make-set))

        (queue-enqueue! q (cons beginWord 1))
        (set! visited (set-add visited beginWord))

        (define (generate-next-words current-word)
          (define len (string-length current-word))
          (define nexts '())
          (for ([i (range len)])
            (define prefix (substring current-word 0 i))
            (define suffix (substring current-word (+ i 1) len))
            (for ([char-code (range (char->integer #\a) (add1 (char->integer #\z)))])
              (define c (integer->char char-code))
              (unless (char=? c (string-ref current-word i))
                (define new-word (string-append prefix (string c) suffix))
                (when (set-member? word-set new-word)
                  (set! nexts (cons new-word nexts))))))
          nexts)

        (let loop ()
          (if (queue-empty? q)
              0
              (let* ([current-pair (queue-dequeue! q)]
                     [current-word (car current-pair)]
                     [current-level (cdr current-pair)])

                (when (string=? current-word endWord)
                  (error 'found current-level))

                (for ([next-word (generate-next-words current-word)])
                  (unless (set-member? visited next-word)
                    (set! visited (set-add visited next-word))
                    (queue-enqueue! q (cons next-word (+ current-level 1)))))
                (loop))))

        (with-handlers ([exn:fail:user?
                         (lambda (e)
                           (if (eq? (exn:fail:user-message e) 'found)
                               (exn:fail:user-data e)
                               (error e)))])
          (loop))))