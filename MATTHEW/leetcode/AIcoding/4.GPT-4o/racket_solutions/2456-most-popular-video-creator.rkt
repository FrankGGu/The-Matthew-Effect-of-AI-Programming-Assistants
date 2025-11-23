(define (mostPopularCreator videos)
  (define video-map (make-hash))
  (define creator-map (make-hash))

  (for-each (lambda (video)
              (define creator (car video))
              (define title (cadr video))
              (define views (string->number (caddr video)))
              (hash-set! video-map title views)
              (if (hash-has-key? creator-map creator)
                  (hash-set! creator-map creator (+ (hash-ref creator-map creator) views))
                  (hash-set! creator-map creator views)))
            videos)

  (define max-views (apply max (hash-values creator-map)))
  (define popular-creators 
    (filter (lambda (c) (= (hash-ref creator-map c) max-views))
            (hash-keys creator-map)))

  (define sorted-creators 
    (sort popular-creators (lambda (a b) (string<? a b))))

  (map (lambda (creator)
         (let* ((titles (filter (lambda (video) (string=? (car video) creator)) videos))
                (max-title (apply max (map cadr titles))))
           (list creator max-title)))
       sorted-creators))