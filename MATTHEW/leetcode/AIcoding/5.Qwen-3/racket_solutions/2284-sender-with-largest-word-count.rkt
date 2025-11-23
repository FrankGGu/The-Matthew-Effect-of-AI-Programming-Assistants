#lang racket

(define (largest-word-count messages)
  (define counts (make-hash))
  (for-each
   (lambda (msg)
     (let* ([parts (string-split msg)]
            [count (length parts)])
       (hash-update! counts msg (lambda (x) (+ x count)) 0)))
   messages)
  (let loop ([max-count 0] [max-sender ""])
    (if (hash-empty? counts)
        max-sender
        (let* ([sender (hash-key (hash-min counts))]
               [count (hash-ref counts sender)])
          (if (> count max-count)
              (loop count sender)
              (loop max-count max-sender))))))

(define (main)
  (define input (read-line))
  (define messages (map (lambda (s) (substring s 1 (- (string-length s) 1))) (string-split input #\,)))
  (display (largest-word-count messages)))

(main)