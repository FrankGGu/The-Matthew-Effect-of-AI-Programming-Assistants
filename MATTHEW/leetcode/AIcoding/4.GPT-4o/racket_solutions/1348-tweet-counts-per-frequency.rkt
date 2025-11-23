(define TweetCounts
  (class object%
    (super-new)
    (define frequency-map (hash))

    (define (add-tweet tweet-time tweet-name)
      (let ((times (hash-ref frequency-map tweet-name '())))
        (hash-set! frequency-map tweet-name (cons tweet-time times))))

    (define (get-tweets-per-frequency freq tweet-name)
      (define intervals
        (case freq
          (("minute") 60)
          (("hour") 3600)
          (( "day") 86400)))
      (define tweet-times (hash-ref frequency-map tweet-name '()))
      (define counts (make-vector (ceiling (/ (apply max tweet-times) intervals)) 0))
      (for-each (lambda (time)
                  (define index (quotient time intervals))
                  (vector-set! counts index (+ 1 (vector-ref counts index))))
                tweet-times)
      (map vector->list (vector->list counts)))

    (define/public (tweet tweet-name tweet-time)
      (add-tweet tweet-time tweet-name))

    (define/public (get-tweet-counts freq tweet-name)
      (get-tweets-per-frequency freq tweet-name))
  ))