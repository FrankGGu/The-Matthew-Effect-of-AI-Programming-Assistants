(define (num-friend-requests ages)
  (define age-counts (make-vector 121 0)) ; Ages 1 to 120

  ; Populate age-counts
  (for-each (lambda (age)
              (when (<= 1 age 120) ; Ensure age is within valid range
                (vector-set! age-counts age (+ (vector-ref age-counts age) 1))))
            ages)

  (define total-requests 0)

  ; Iterate through all possible age_x
  ; Optimization: age-x must be at least 15 for any requests to be sent.
  ; This is because if age-x < 15, then 0.5 * age-x + 7 >= age-x,
  ; making the condition (age-y > 0.5 * age-x + 7) and (age-y <= age-x) impossible.
  (for ([age-x (in-range 15 121)]) ; age-x from 15 to 120
    (define count-x (vector-ref age-counts age-x))
    (when (> count-x 0) ; Only proceed if there are people of age-x
      ; Iterate through all possible age_y
      (for ([age-y (in-range 1 121)]) ; age-y from 1 to 120
        (define count-y (vector-ref age-counts age-y))
        (when (> count-y 0) ; Only proceed if there are people of age-y

          ; Conditions for x sending request to y:
          ; 1. age[y] > 0.5 * age[x] + 7
          ; 2. age[y] <= age[x]
          ; The third condition from the problem statement (age[y] > 100 and age[x] < 100)
          ; is implicitly handled by the first two conditions and age constraints (1-120).
          ; If age[y] <= age[x] is true, then if age[x] < 100, age[y] must also be < 100.
          ; If age[x] >= 100, the condition (age[y] > 100 and age[x] < 100) is false anyway.
          (when (and (> age-y (+ (* 0.5 age-x) 7))
                     (<= age-y age-x))
            (if (= age-x age-y)
                ; If ages are the same, a person cannot send a request to themselves.
                ; So, count-x people can send to (count-x - 1) others.
                (set! total-requests (+ total-requests (* count-x (- count-x 1))))
                ; If ages are different, each of count-x people can send to each of count-y people.
                (set! total-requests (+ total-requests (* count-x count-y))))))))
  total-requests)