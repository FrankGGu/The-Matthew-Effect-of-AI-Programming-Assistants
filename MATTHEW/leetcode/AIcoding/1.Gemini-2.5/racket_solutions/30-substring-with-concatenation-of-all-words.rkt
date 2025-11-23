#lang racket

(define (find-substring s words)
  (define s-len (string-length s))
  (define num-words (length words))

  (if (zero? num-words)
      '()
      (begin
        (define word-len (string-length (car words)))
        (define total-len (* num-words word-len))

        (if (> total-len s-len)
            '()
            (begin
              (define words-map
                (for/fold ((m (hash))) ((w words))
                  (hash-update m w add1 0)))

              (define result '())

              (for ((i (in-range word-len)))
                (define current-word-counts (hash))
                (define left i)
                (define count 0)

                (for ((j (in-range i (- s-len word-len -1) word-len)))
                  (define current-word (substring s j (+ j word-len)))

                  (cond
                    ((hash-has-key? words-map current-word)
                     (hash-update! current-word-counts current-word add1 0)
                     (set! count (add1 count))

                     (while (> (hash-ref current-word-counts current-word 0)
                               (hash-ref words-map current-word 0))
                       (define left-word (substring s left (+ left word-len)))
                       (hash-update! current-word-counts left-word sub1)
                       (set! count (sub1 count))
                       (set! left (+ left word-len)))

                     (when (= count num-words)
                       (set! result (cons left result))))

                    (else
                     (set! current-word-counts (hash))
                     (set! count 0)
                     (set! left (+ j word-len))))))

              (reverse result))))))