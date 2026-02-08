(define (max-candies boxes candies keys initial-boxes)
  (let loop ([have-boxes (list)]
             [have-keys (set->list (list->set keys))]
             [candies-count 0]
             [available-boxes (set->list (list->set initial-boxes))])
    (if (null? available-boxes)
        candies-count
        (let* ([box-index (car available-boxes)]
               [rest-boxes (cdr available-boxes)])
          (if (or (member box-index have-boxes) (not (member box-index (map car boxes))))
              (loop have-boxes have-keys candies-count rest-boxes)
              (if (or (list-ref boxes box-index) (member box-index have-keys))
                  (let* ([new-candies (+ candies-count (list-ref candies box-index))]
                         [new-keys (append have-keys (list-ref keys box-index))]
                         [new-have-boxes (cons box-index have-boxes)]
                         [new-available-boxes (append rest-boxes (filter (lambda (box-index) (not (member box-index new-have-boxes))) (let loop2 ([i 0] [result '()]) (if (= i (length boxes)) result (if (list-ref boxes i) (loop2 (+ i 1) (cons i result)) (loop2 (+ i 1) result))))))])
                    (loop new-have-boxes new-keys new-candies new-available-boxes))
                  (loop have-boxes have-keys candies-count rest-boxes)))))))

(define (maximum-candies boxes candies keys initial-boxes)
  (max-candies boxes candies keys initial-boxes))