(define (can-choose groups nums)
  (define nums-vec (list->vector nums))
  (define nums-len (vector-length nums-vec))
  (define groups-vec (map list->vector groups))
  (define groups-len (vector-length groups-vec))

  (define (match-group-at-idx? group-idx nums-start-idx)
    (let ([current-group-vec (vector-ref groups-vec group-idx)])
      (let ([group-len (vector-length current-group-vec)])
        (if (> (+ nums-start-idx group-len) nums-len)
            #f ; Not enough elements in nums-vec
            (let loop ([g-offset 0])
              (if (>= g-offset group-len)
                  #t ; All group elements matched
                  (if (= (vector-ref nums-vec (+ nums-start-idx g-offset))
                         (vector-ref current-group-vec g-offset))
                      (loop (+ g-offset 1))
                      #f)))))))

  (define (helper current-group-idx current-nums-start-idx)
    (cond
      [(>= current-group-idx groups-len) #t] ; All groups found
      [else
        (let ([current-group-vec (vector-ref groups-vec current-group-idx)])
          (let ([group-len (vector-length current-group-vec)])
            (let loop ([i current-nums-start-idx])
              (cond
                [(> (+ i group-len) nums-len) #f] ; Not enough elements left in nums-vec
                [(match-group-at-idx? current-group-idx i)
                  ; Found current-group starting at index i
                  (helper (+ current-group-idx 1) (+ i group-len))]
                [else
                  ; Try next starting position in nums-vec
                  (loop (+ i 1))]))))])))

  (helper 0 0))