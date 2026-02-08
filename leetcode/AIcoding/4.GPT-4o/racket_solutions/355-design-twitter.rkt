(define (Twitter)
  (define tweets '())
  (define user-tweets (make-hash))
  (define followings (make-hash))

  (define (postTweet userId tweetId)
    (set! tweets (cons (list userId tweetId) tweets))
    (define user-tweet-list (hash-ref user-tweets userId '()))
    (hash-set! user-tweets userId (cons tweetId user-tweet-list)))

  (define (getNewsFeed userId)
    (define followees (hash-ref followings userId '()))
    (define all-tweets (append tweets
                               (apply append (map (lambda (x) (hash-ref user-tweets x '())) followees))))
    (define sorted-tweets (take (sort all-tweets (lambda (a b) (> (second a) (second b)))) 10))
    (map second sorted-tweets))

  (define (follow(followerId, followeeId)
    (define followees (hash-ref followings followerId '()))
    (hash-set! followings followerId (cons followeeId followees)))

  (define (unfollow(followerId, followeeId)
    (define followees (hash-ref followings followerId '()))
    (hash-set! followings followerId (filter (lambda (x) (not (= x followeeId))) followees)))

  (define (getMethods)
    (list (lambda (userId tweetId) (postTweet userId tweetId))
          (lambda (userId) (getNewsFeed userId))
          (lambda (followerId followeeId) (follow followerId followeeId))
          (lambda (followerId followeeId) (unfollow followerId followeeId))))

  (getMethods))