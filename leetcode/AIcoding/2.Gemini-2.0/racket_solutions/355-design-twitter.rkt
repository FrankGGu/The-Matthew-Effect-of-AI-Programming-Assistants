(define (make-twitter)
  (let ((user-tweets (make-hash))
        (user-followers (make-hash))
        (timestamp 0))

    (define (post-tweet user-id tweet-id)
      (hash-update! user-tweets user-id (lambda (tweets) (cons (cons timestamp tweet-id) tweets)) '()))

    (define (get-news-feed user-id)
      (let ((followers (hash-ref user-followers user-id '())))
        (let loop ((users (cons user-id followers))
                   (tweets '()))
          (cond
            ((null? users)
             (let ((sorted-tweets (sort tweets > #:key car)))
               (map cdr (take sorted-tweets (min 10 (length sorted-tweets))))))
            (else
             (let ((current-user (car users)))
               (let ((user-tweets-list (hash-ref user-tweets current-user '())))
                 (loop (cdr users) (append tweets user-tweets-list)))))))))

    (define (follow user-id follower-id)
      (hash-update! user-followers user-id (lambda (followers) (if (member follower-id followers) followers (cons follower-id followers))) '()))

    (define (unfollow user-id follower-id)
      (hash-update! user-followers user-id (lambda (followers) (remove follower-id followers)) '()))

    (lambda (method . args)
      (set! timestamp (+ timestamp 1))
      (case method
        ((postTweet) (apply post-tweet args))
        ((getNewsFeed) (apply get-news-feed args))
        ((follow) (apply follow args))
        ((unfollow) (apply unfollow args))))))