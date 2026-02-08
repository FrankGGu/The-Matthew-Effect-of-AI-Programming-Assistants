(define/contract (most-popular-creator creators ids views)
  (-> (listof string?) (listof string?) (listof exact-integer?) (listof (listof string?)))
  (let* ([n (length creators)]
         [creator-views (make-hash)]
         [creator-max (make-hash)]
         [max-popularity -inf.0]
         [result '()])
    (for ([i (in-range n)])
      (let ([creator (list-ref creators i)]
            [id (list-ref ids i)]
            [view (list-ref views i)])
        (hash-update! creator-views creator (lambda (v) (+ v view)) 0)
        (let ([current (hash-ref creator-views creator)])
        (when (> current max-popularity)
          (set! max-popularity current)
          (set! result '()))
        (when (= current max-popularity)
          (hash-update! creator-max creator
                        (lambda (pair)
                          (let ([max-view (car pair)]
                                [max-id (cdr pair)])
                          (cond
                            [(> view max-view) (cons view id)]
                            [(= view max-view) (cons max-view (if (string<? id max-id) id max-id))]
                            [else pair]))
                        (cons -inf.0 "")))))
    (for ([(creator pair) (in-hash creator-max)]
          #:when (= (hash-ref creator-views creator) max-popularity))
      (set! result (cons (list creator (cdr pair)) result)))
    (sort result string<? #:key car)))