(define (can-transform start end)
  (define n (string-length start))
  (define i 0) ; pointer for start string
  (define j 0) ; pointer for end string

  (let loop ()
    ;; Skip 'X's in start
    (set! i (let skip-x-s (idx-s)
              (if (and (< idx-s n) (char=? (string-ref start idx-s) #\X))
                  (skip-x-s (+ idx-s 1))
                  idx-s)))
    ;; Skip 'X's in end
    (set! j (let skip-x-e (idx-e)
              (if (and (< idx-e n) (char=? (string-ref end idx-e) #\X))
                  (skip-x-e (+ idx-e 1))
                  idx-e)))

    ;; Check if both pointers reached end
    (cond
      ((and (= i n) (= j n)) #t) ; Both exhausted, transformation is possible
      ((or (= i n) (= j n)) #f)  ; One exhausted but not the other, different non-'X' count or order
      (else
       ;; Now, start[i] and end[j] are guaranteed to be non-'X' characters
       (define char-s (string-ref start i))
       (define char-e (string-ref end j))

       ;; Characters must be the same to maintain relative order of L/R
       (if (not (char=? char-s char-e))
           #f ; Mismatch in character type, transformation is impossible
           ;; Check movement constraints
           (cond
             ((char=? char-s #\L)
              ;; 'L' can only move left (or stay in place)
              ;; So, its final position 'j' must be less than or equal to its starting position 'i'
              (if (> j i)
                  #f ; 'L' moved right, which is impossible
                  (begin
                    (set! i (+ i 1))
                    (set! j (+ j 1))
                    (loop)))) ; Continue to the next pair of non-'X' characters
             ((char=? char-s #\R)
              ;; 'R' can only move right (or stay in place)
              ;; So, its final position 'j' must be greater than or equal to its starting position 'i'
              (if (< j i)
                  #f ; 'R' moved left, which is impossible
                  (begin
                    (set! i (+ i 1))
                    (set! j (+ j 1))
                    (loop)))) ; Continue to the next pair of non-'X' characters
             (else #f))))))) ; This case should ideally not be reached if inputs only contain 'L', 'R', 'X'