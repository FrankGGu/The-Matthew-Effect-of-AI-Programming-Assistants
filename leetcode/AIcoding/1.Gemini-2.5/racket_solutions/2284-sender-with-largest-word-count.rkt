#lang racket

(define (sender-with-largest-word-count messages senders)
  (define sender-word-counts (make-hash))

  (for ([message messages]
        [sender senders])
    (define words (string-split message " "))
    (define word-count (length (filter (lambda (s) (not (string=? s ""))) words)))

    (hash-set! sender-word-counts
               sender
               (+ word-count (hash-ref sender-word-counts sender 0))))

  (define max-count -1)
  (define result-sender "") 

  (hash-for-each
   sender-word-counts
   (lambda (sender count)
     (when (> count max-count)
       (set! max-count count)
       (set! result-sender sender))
     (when (and (= count max-count) (string>? sender result-sender))
       (set! result-sender sender))))

  result-sender)