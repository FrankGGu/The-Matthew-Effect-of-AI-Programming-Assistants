#lang racket

(require data/hash)
(require data/set)
(require data/queue)

(define (alien-order words)
  (define char-set (set))
  (for-each (lambda (word)
              (for-each (lambda (c) (set-add! char-set c)) (string->list word)))
            words)

  (define graph (make-hash))
  (define in-degree (make-hash))

  (for-each (lambda (c) (hash-set! in-degree c 0)) (set-elems char-set))

  (define invalid-order-detected #f)

  (define num-words (length words))
  (for ([i (in-range (- num-words 1))])
    (when (not invalid-order-detected)
      (define w1 (list-ref words i))
      (define w2 (list-ref words (+ i 1)))

      (define len1 (string-length w1))
      (define len2 (string-length w2))

      (define diff-found #f)
      (for ([j (in-range (min len1 len2))] #:when (not diff-found))
        (define c1 (string-ref w1 j))
        (define c2 (string-ref w2 j))
        (when (not (char=? c1 c2))
          (set! diff-found #t)
          (define current-neighbors (hash-ref graph c1 '()))
          (unless (member c2 current-neighbors)
            (hash-set! graph c1 (cons c2 current-neighbors))
            (hash-update! in-degree c2 add1 0))))

      (when (and (not diff-found) (> len1 len2))
        (set! invalid-order-detected #t))))

  (if invalid-order-detected
      ""
      (let ()
        (define q (make-queue))
        (define result-chars '())

        (for-each (lambda (c)
                    (when (= (hash-ref in-degree c 0) 0)
                      (queue-add! q c)))
                  (set-elems char-set))

        (while (not (queue-empty? q))
          (define c (queue-remove! q))
          (set! result-chars (append result-chars (list c)))

          (define neighbors (hash-ref graph c '()))
          (for-each (lambda (neighbor)
                      (hash-update! in-degree neighbor sub1)
                      (when (= (hash-ref in-degree neighbor) 0)
                        (queue-add! q neighbor)))
                    neighbors))

        (if (= (length result-chars) (set-count char-set))
            (list->string result-chars)
            "")))