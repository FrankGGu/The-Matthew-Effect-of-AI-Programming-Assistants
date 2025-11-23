(require racket/set)

(define twitter%
  (class object%
    (init-field [tweets '()]
                [follows (make-hash)]
                [timestamp 0])

    (define/public (post-tweet userId tweetId)
      (set! timestamp (+ timestamp 1))
      (set! tweets (cons (list tweetId userId timestamp) tweets)))

    (define/public (get-news-feed userId)
      (define (get-followees id)
        (hash-ref follows id (set)))

      (define user-and-followees
        (set-add (get-followees userId) userId))

      (define (filter-and-collect-news-feed)
        (let loop ([current-tweets tweets]
                   [collected-tweets '()]
                   [count 0])
          (cond
            [(or (null? current-tweets) (= count 10)) (reverse collected-tweets)]
            [else
             (define current-tweet (car current-tweets))
             (define tweet-author (list-ref current-tweet 1))
             (define tweet-id (list-ref current-tweet 0))
             (if (set-member? user-and-followees tweet-author)
                 (loop (cdr current-tweets) (cons tweet-id collected-tweets) (+ count 1))
                 (loop (cdr current-tweets) collected-tweets count))])))
      (filter-and-collect-news-feed))

    (define/public (follow followerId followeeId)
      (hash-update! follows followerId
                    (lambda (current-followees) (set-add current-followees followeeId))
                    (set)))

    (define/public (unfollow followerId followeeId)
      (hash-update! follows followerId
                    (lambda (current-followees) (set-remove current-followees followeeId))
                    (set)))
    ))

(define (twitter)
  (new twitter%))