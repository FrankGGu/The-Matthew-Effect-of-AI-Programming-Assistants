(define twitter%
  (class object%
    (super-new)
    (init-field)
    (define users (make-hash))

    (define/public (postTweet userId tweetId)
      (when (not (hash-has-key? users userId))
        (hash-set! users userId (list (list (current-seconds) tweetId) (set))))
      (let ([user (hash-ref users userId)])
        (set-car! user (cons (list (current-seconds) tweetId) (car user))))))

    (define/public (getNewsFeed userId)
      (let ([tweets '()]
            [followees (if (hash-has-key? users userId) (set->list (cadr (hash-ref users userId))) '()]))
        (when (hash-has-key? users userId)
          (set! tweets (car (hash-ref users userId))))
        (for ([followee followees])
          (when (hash-has-key? users followee)
            (set! tweets (append (car (hash-ref users followee)) tweets)))
        (let* ([sorted-tweets (sort tweets (lambda (a b) (> (car a) (car b))))]
               [result (map cadr (take sorted-tweets (min 10 (length sorted-tweets))))])
          result)))

    (define/public (follow followerId followeeId)
      (when (not (hash-has-key? users followerId))
        (hash-set! users followerId (list '() (set))))
      (set-add! (cadr (hash-ref users followerId)) followeeId))

    (define/public (unfollow followerId followeeId)
      (when (hash-has-key? users followerId)
        (set-remove! (cadr (hash-ref users followerId)) followeeId)))))