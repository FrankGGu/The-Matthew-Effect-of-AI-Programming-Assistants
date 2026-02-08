(define my-calendar-three%
  (class object%
    (define events (make-hash))

    (define/public (book start end)
      (hash-set! events start (+ (hash-ref events start 0) 1))
      (hash-set! events end (+ (hash-ref events end 0) -1))

      (let* ([points (sort (hash-keys events) <)]
             [current-overlap 0]
             [max-overlap 0])
        (for ([p points])
          (set! current-overlap (+ current-overlap (hash-ref events p 0)))
          (set! max-overlap (max max-overlap current-overlap)))
        max-overlap))))