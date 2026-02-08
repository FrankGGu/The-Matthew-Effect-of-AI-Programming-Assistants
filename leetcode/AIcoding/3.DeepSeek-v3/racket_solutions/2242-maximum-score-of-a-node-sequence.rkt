(define (maximum-score edges)
  (define adj (make-hash))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (hash-update! adj u (lambda (lst) (cons v lst)) '())
      (hash-update! adj v (lambda (lst) (cons u lst)) '())))

  (for ([(u lst) adj])
    (hash-update! adj u (lambda (lst) (sort lst >)) '())

  (define max-score -1)

  (for ([edge edges])
    (let* ([u (first edge)]
           [v (second edge)]
           [u-neighbors (hash-ref adj u '())]
           [v-neighbors (hash-ref adj v '())]
           [candidates '()])

      (define (add-candidates lst limit)
        (for ([x lst] #:break (>= (length candidates) limit))
          (when (and (not (equal? x v)) (not (equal? x u)))
            (set! candidates (cons x candidates)))))

      (add-candidates u-neighbors 2)
      (add-candidates v-neighbors 2)

      (for ([a candidates])
        (for ([b candidates] #:when (not (equal? a b)))
          (let ([score (+ u v a b)])
            (when (> score max-score)
              (set! max-score score))))))

  (if (> max-score -1) max-score -1))