(define (number-of-ways corridor)
  (define MOD 1000000007)

  ;; Find all indices of 'S' (seats) in the corridor
  (define seat-indices
    (for/list ([i (in-range (string-length corridor))]
               #:when (char=? (string-ref corridor i) #\S))
      i))

  (define num-seats (length seat-indices))

  ;; Handle edge cases:
  ;; If there are no seats or an odd number of seats, it's impossible to divide
  ;; into segments of exactly two seats each.
  (cond
    [(or (= num-seats 0) (odd? num-seats))
     0]
    [else
     ;; Initialize the number of ways to 1
     (define ways 1)

     ;; Iterate through the gaps where dividers can be placed.
     ;; For seat indices s_0, s_1, s_2, s_3, ..., s_{N-1}:
     ;; We need to place dividers after seat s_1, s_3, s_5, ...
     ;; and before seat s_2, s_4, s_6, ... respectively.
     ;; The number of choices for each divider is the distance between the seats.
     ;; Specifically, we multiply (s_2 - s_1), (s_4 - s_3), ..., (s_{N-2} - s_{N-3}).
     ;; The loop variable `i` corresponds to the first index of each pair (s_1, s_3, s_5, ...).
     ;; So, `i` starts from 1 and increments by 2, up to `N-3`.
     (for ([i (in-range 1 (- num-seats 2) 2)])
       (set! ways (modulo (* ways (- (list-ref seat-indices (+ i 1))
                                     (list-ref seat-indices i)))
                           MOD)))
     ways]))