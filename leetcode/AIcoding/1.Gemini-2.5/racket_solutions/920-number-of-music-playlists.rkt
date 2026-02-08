(define (num-music-playlists N L K)
  (let* ((MOD 1000000007)
         ;; dp is a vector of vectors. (L+1) rows, (N+1) columns.
         ;; dp[i][j] stores the number of playlists of length i with j unique songs.
         (dp (build-vector (+ L 1) (lambda (idx) (make-vector (+ N 1) 0)))))

    ;; Base case: 0 length playlist, 0 unique songs, 1 way (empty playlist)
    (vector-set! (vector-ref dp 0) 0 1)

    ;; Fill DP table
    (for ([i (in-range 1 (+ L 1))]) ; Playlist length from 1 to L
      (for ([j (in-range 1 (+ N 1))]) ; Number of unique songs from 1 to N
        ;; A playlist of length i cannot have more than i unique songs
        (when (<= j i)
          (let* ((prev-dp-row (vector-ref dp (- i 1)))
                 ;; Case 1: The i-th song is a new song.
                 ;; We had j-1 unique songs in an (i-1)-length playlist.
                 ;; There are (N - (j-1)) choices for this new song.
                 ;; (- N j -1) is equivalent to (N - (j-1)).
                 (term1 (modulo (* (vector-ref prev-dp-row (- j 1)) (- N j -1)) MOD))
                 ;; Case 2: The i-th song is an old song (already played in the first i-1 songs).
                 ;; We had j unique songs in an (i-1)-length playlist.
                 ;; To replay a song, it must not be among the K most recently played songs.
                 ;; So, there are max(0, j - K) choices for the old song.
                 (term2 (modulo (* (vector-ref prev-dp-row j) (max 0 (- j K))) MOD)))
            (vector-set! (vector-ref dp i) j (modulo (+ term1 term2) MOD))))))

    ;; The result is the number of playlists of length L with N unique songs.
    (vector-ref (vector-ref dp L) N)))