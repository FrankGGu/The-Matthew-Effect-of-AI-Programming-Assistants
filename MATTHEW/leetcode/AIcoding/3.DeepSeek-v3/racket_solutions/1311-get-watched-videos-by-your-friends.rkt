(define (watched-videos-by-friends watched-videos friends id level)
  (define (bfs start)
    (let loop ([queue (list start)]
               [visited (set)]
               [current-level 0])
      (if (or (null? queue) (> current-level level))
          (set)
          (let* ([size (length queue)]
                 [new-queue (append (cdr queue)
                                   (filter (lambda (x) (not (set-member? visited x)))
                                           (foldl append '() (map (lambda (x) (list-ref friends x)) (take queue size))))]
                 [new-visited (foldl (lambda (x acc) (set-add acc x)) visited (take queue size))])
            (if (= current-level level)
                (list->set (take queue size))
                (loop new-queue new-visited (+ current-level 1)))))))

  (let ([friends-at-level (bfs id)])
    (if (set-empty? friends-at-level)
        '()
        (let* ([videos (foldl (lambda (x acc) (append acc (list-ref watched-videos x))) '() (set->list friends-at-level))]
               [video-count (make-hash)])
          (for-each (lambda (v)
                      (hash-set! video-count v (+ (hash-ref video-count v 0) 1)))
                    videos)
          (map car (sort (hash-map video-count (lambda (k v) (cons k v)))
                        (lambda (a b)
                          (if (= (cdr a) (cdr b))
                              (string<? (car a) (car b))
                              (< (cdr a) (cdr b)))))))))