#lang racket

(define (longest-string-chain words)
  (define sorted-words (sort words (lambda (s1 s2) (< (string-length s1) (string-length s2)))))
  (define dp (make-hash))
  (define max-chain-length 0)

  (for ([word sorted-words])
    (define current-word-chain-length 1)
    (define len (string-length word))

    (for ([i (range len)])
      (define predecessor (string-append (substring word 0 i) (substring word (+ i 1) len)))
      (when (hash-has-key? dp predecessor)
        (set! current-word-chain-length (max current-word-chain-length (+ (hash-ref dp predecessor) 1)))))

    (hash-set! dp word current-word-chain-length)
    (set! max-chain-length (max max-chain-length current-word-chain-length)))

  max-chain-length)