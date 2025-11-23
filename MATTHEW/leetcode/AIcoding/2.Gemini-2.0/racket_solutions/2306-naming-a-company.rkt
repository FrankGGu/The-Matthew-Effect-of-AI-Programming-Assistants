(define (distinct-names ideas)
  (define (group-by-first-char ideas)
    (let loop ([ideas ideas] [groups (hash)])
      (if (null? ideas)
          groups
          (let ([idea (car ideas)]
                [first-char (string->list (substring idea 0 1))])
            (hash-update groups (car first-char)
                         (lambda (existing) (set-add existing idea))
                         (set idea))
            (loop (cdr ideas) groups)))))

  (define (count-distinct-pairs groups)
    (let ([keys (hash-keys groups)])
      (let loop ([keys keys] [count 0])
        (if (null? keys)
            count
            (let ([key1 (car keys)]
                  [set1 (hash-ref groups key1)])
              (let loop2 ([remaining-keys (cdr keys)])
                (if (null? remaining-keys)
                    count
                    (let ([key2 (car remaining-keys)]
                          [set2 (hash-ref groups key2)])
                      (let ([intersection-size (set-count (set-intersect set1 set2))])
                        (loop2 (cdr remaining-keys) (+ count (* (- (set-count set1) intersection-size)
                                                                (- (set-count set2) intersection-size))))))))
              (loop (cdr keys) count))))))

  (* 2 (count-distinct-pairs (group-by-first-char ideas))))