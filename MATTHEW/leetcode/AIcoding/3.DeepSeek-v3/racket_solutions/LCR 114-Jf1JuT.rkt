(define (alien-order words)
  (define graph (make-hash))
  (define in-degree (make-hash))

  (define (build-graph words)
    (for ([word words])
      (for ([c (string->list word)])
        (hash-set! in-degree c 0)))

    (for ([i (in-range (- (length words) 1))])
      (let* ([word1 (list-ref words i)]
             [word2 (list-ref words (+ i 1))]
             [len1 (string-length word1)]
             [len2 (string-length word2)]
             [found #f])
        (for ([j (in-range (min len1 len2))])
          (let ([c1 (string-ref word1 j)]
                [c2 (string-ref word2 j)])
            (when (and (not found) (not (eq? c1 c2)))
              (set! found #t)
              (hash-update! graph c1 (lambda (lst) (cons c2 lst)) '())
              (hash-update! in-degree c2 add1 0))))))))

  (define (topological-sort)
    (define queue (make-queue))
    (define result '())

    (hash-for-each in-degree (lambda (k v) (when (zero? v) (enqueue! queue k))))

    (let loop ()
      (unless (queue-empty? queue)
        (let ([c (dequeue! queue)])
          (set! result (cons c result))
          (when (hash-has-key? graph c)
            (for ([neighbor (hash-ref graph c)])
              (hash-update! in-degree neighbor sub1 0)
              (when (zero? (hash-ref in-degree neighbor))
                (enqueue! queue neighbor)))))
        (loop)))

    (if (= (length result) (hash-count in-degree))
        (list->string (reverse result))
        ""))

  (build-graph words)
  (topological-sort))