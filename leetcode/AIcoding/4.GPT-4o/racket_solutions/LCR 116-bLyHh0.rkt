(define (find-circle-num isConnected)
  (define (dfs city)
    (set! visited (set-add visited city))
    (for-each (lambda (neighbor)
                (when (and (= (vector-ref (vector-ref isConnected city) neighbor) 1)
                           (not (set-member? visited neighbor)))
                  (dfs neighbor)))
              (range (vector-length isConnected))))

  (define visited (set))
  (define count 0)

  (for-each (lambda (i)
              (when (not (set-member? visited i))
                (dfs i)
                (set! count (+ count 1))))
            (range (vector-length isConnected)))

  count)