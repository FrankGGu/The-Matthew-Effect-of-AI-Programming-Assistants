(define (maximize-profit n offers)
  (define offers-by-end (make-vector n '()))

  ;; Group offers by their end house index
  (for-each (lambda (offer)
              (define start (car offer))
              (define end (cadr offer))
              (define profit (caddr offer))
              (vector-set! offers-by-end end (cons offer (vector-ref offers-by-end end))))
            offers)

  ;; dp[i] will store the maximum profit considering offers that end at or before house (i-1).
  ;; dp has size n+1. dp[0] represents the profit before any houses (0).
  ;; dp[i] stores the maximum profit achievable up to house (i-1).
  (define dp (make-vector (add1 n) 0))

  ;; Iterate through houses from 0 to n-1.
  ;; i represents the current dp index, ranging from 1 to n.
  ;; The actual house index being considered as an end point is (sub1 i).
  (for ([i (in-range 1 (add1 n))])
    ;; Option 1: Do not take any offer ending at house (i-1).
    ;; The maximum profit remains the same as the maximum profit up to house (i-2).
    (vector-set! dp i (vector-ref dp (sub1 i)))

    ;; Option 2: Consider offers that end exactly at house (i-1).
    (define current-house-idx (sub1 i)) ; This is the 0-indexed house number (0 to n-1)

    ;; Retrieve all offers that end at current-house-idx
    (define offers-for-this-end (vector-ref offers-by-end current-house-idx))

    (for-each (lambda (offer)
                (define start (car offer))
                ;; (define end (cadr offer)) ; 'end' is current-house-idx
                (define profit (caddr offer))

                ;; Calculate profit if this offer is taken:
                ;; profit of current offer + maximum profit from offers ending before 'start' house.
                ;; dp[start] stores the maximum profit up to house (start-1).
                (define profit-if-taken (+ profit (vector-ref dp start)))

                ;; Update dp[i] if taking this offer yields a higher profit
                (vector-set! dp i (max (vector-ref dp i) profit-if-taken)))
              offers-for-this-end))

  ;; The final answer is the maximum profit achievable up to house (n-1), stored in dp[n].
  (vector-ref dp n))