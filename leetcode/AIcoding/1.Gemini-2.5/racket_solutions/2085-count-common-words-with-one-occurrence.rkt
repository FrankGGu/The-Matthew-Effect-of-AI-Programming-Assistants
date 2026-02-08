#lang racket

(define (build-frequency-map words)
  (define counts (make-hash))
  (for-each (lambda (word)
              (hash-update! counts word add1 0))
            words)
  counts)

(define (count-common-words-with-one-occurrence words1 words2)
  (define words1-counts (build-frequency-map words1))
  (define words2-counts (build-frequency-map words2))

  (for/sum ([word (hash-keys words1-counts)])
    (define count1 (hash-ref words1-counts word))
    (if (and (= count1 1)
             (hash-has-key? words2-counts word)
             (= (hash-ref words2-counts word) 1))
        1
        0)))