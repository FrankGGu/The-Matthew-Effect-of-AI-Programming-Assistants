(define (num-music-playlists n goal k)
  (define memo (make-hash))

  (define (solve remaining songs)
    (cond
      [(and (= remaining 0) (= songs n)) 1]
      [(or (= remaining 0) (> songs n)) 0]
      [else
       (define key (cons remaining songs))
       (if (hash-has-key? memo key)
           (hash-ref memo key)
           (let* ([new-songs-ways (* (- n songs) (solve (- remaining 1) (+ songs 1))) ]
                  [old-songs-ways (* (max 0 (- songs k)) (solve (- remaining 1) songs)) ]
                  [total-ways (modulo (+ new-songs-ways old-songs-ways) 1000000007)])
             (hash-set! memo key total-ways)
             total-ways))]))

  (solve goal 0))