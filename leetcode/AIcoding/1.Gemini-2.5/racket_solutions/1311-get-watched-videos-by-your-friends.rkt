#lang racket

(define (get-watched-videos-by-your-friends num friends watchedVideos id level)

  (define (bfs-find-friends start-id target-level)
    (let ((q (list (list start-id 0))) ; Queue: (list (person-id current-level))
          (visited (make-hash))        ; Hash set for visited nodes
          (level-friends (make-hash))) ; Hash set for friends at target-level

      (hash-set! visited start-id #t)

      (let bfs-loop ((current-q q))
        (if (empty? current-q)
            (hash-keys level-friends) ; Return list of friends at target-level
            (let* ((node (car current-q))
                   (person (car node))
                   (lvl (cadr node))
                   (rest-q (cdr current-q)))

              (when (= lvl target-level)
                (hash-set! level-friends person #t)) ; Add person to level-friends set

              (if (> lvl target-level) ; If we exceed the target level, stop exploring this branch
                  (bfs-loop rest-q)   ; Just process the rest of the queue without adding new nodes
                  (let ((new-neighbors '()))
                    (for-each (lambda (neighbor)
                                (unless (hash-has-key? visited neighbor)
                                  (hash-set! visited neighbor #t)
                                  (set! new-neighbors (cons (list neighbor (+ lvl 1)) new-neighbors))))
                              (list-ref friends person))
                    (bfs-loop (append rest-q (reverse new-neighbors))))))))))

  (define friends-at-level (bfs-find-friends id level))

  (define all-videos (flatten (map (lambda (person-idx) (list-ref watchedVideos person-idx))
                                    friends-at-level)))

  (define video-counts (make-hash))
  (for-each (lambda (video)
              (hash-update! video-counts video add1 0))
            all-videos)

  (define video-pairs (hash->list video-counts))

  (define (compare-videos a b)
    (let ((count-a (cdr a))
          (count-b (cdr b))
          (name-a (car a))
          (name-b (car b)))
      (if (= count-a count-b)
          (string<? name-a name-b)
          (< count-a count-b))))

  (define sorted-video-pairs (sort video-pairs compare-videos))

  (map car sorted-video-pairs))