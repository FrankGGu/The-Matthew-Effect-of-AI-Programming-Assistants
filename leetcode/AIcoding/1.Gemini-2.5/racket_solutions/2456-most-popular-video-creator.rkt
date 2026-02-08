#lang racket

(define (most-popular-video-creator creators video-ids views)
  (define creator-data (make-hash))
  (define num-videos (length creators))

  ;; Step 1: Aggregate views per creator and store video details
  (for ([i (in-range num-videos)])
    (define creator (list-ref creators i))
    (define video-id (list-ref video-ids i))
    (define view-count (list-ref views i))

    (define current-info (hash-ref creator-data creator (list 0 '())))
    (define current-total-views (first current-info))
    (define current-video-list (second current-info))

    (define new-total-views (+ current-total-views view-count))
    (define new-video-list (cons (list video-id view-count) current-video-list))

    (hash-set! creator-data creator (list new-total-views new-video-list)))

  ;; Step 2: Find the maximum total views among all creators
  (define max-total-views 0)
  (for ([creator-info (hash-values creator-data)])
    (define total-views (first creator-info))
    (set! max-total-views (max max-total-views total-views)))

  ;; Step 3: Identify top creators and their most popular video
  (define result '())
  (for ([(creator-name creator-info) (in-hash creator-data)])
    (define total-views (first creator-info))
    (define video-list (second creator-info))

    (when (= total-views max-total-views)
      (define best-video-id "")
      (define max-video-views -1) ; Views are non-negative, so -1 is a safe initial minimum

      (for ([video-info video-list])
        (define current-video-id (first video-info))
        (define current-video-views (second video-info))

        (cond
          [(> current-video-views max-video-views)
           (set! max-video-views current-video-views)
           (set! best-video-id current-video-id)]
          [(= current-video-views max-video-views)
           ;; Tie in views, choose lexicographically smallest video-id
           (when (string<? current-video-id best-video-id)
             (set! best-video-id current-video-id))]))

      (set! result (cons (list creator-name best-video-id) result))))

  ;; Step 4: Return the result (order of creators does not matter)
  result)