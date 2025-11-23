(struct tweet-counts (tweets))

(define (tweet-counts)
  (tweet-counts (make-hash)))

(define (tweet-counts-record-tweet tc tweetName time)
  (hash-update! (tweet-counts-tweets tc) tweetName
                (lambda (times) (cons time times))
                '())
  (void))

(define (tweet-counts-get-tweet-counts-per-frequency tc freq tweetName startTime endTime)
  (define interval-size
    (case freq
      ["minute" 60]
      ["hour" 3600]
      ["day" 86400]
      [else (error "Invalid frequency: " freq)]))

  (define all-times (hash-ref (tweet-counts-tweets tc) tweetName '()))

  (define filtered-times
    (filter (lambda (t) (and (>= t startTime) (<= t endTime))) all-times))

  (define num-intervals
    (+ 1 (quotient (- endTime startTime) interval-size)))

  (define counts (make-vector num-intervals 0))

  (for-each
   (lambda (time)
     (define interval-index (quotient (- time startTime) interval-size))
     (vector-set! counts interval-index
                  (+ (vector-ref counts interval-index) 1)))
   filtered-times)

  (vector->list counts))