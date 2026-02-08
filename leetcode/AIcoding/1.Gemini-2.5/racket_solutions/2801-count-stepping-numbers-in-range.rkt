(define (count-stepping-numbers-in-range low-str high-str)

  (define (is-zero-str s)
    (and (= (string-length s) 1) (char=? (string-ref s 0) #\0)))

  (define (str->digits s)
    (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list s)))

  ;; Function to count stepping numbers up to N (inclusive), where N is a string.
  ;; This function counts 0, 1, ..., N.
  (define (count-up-to s)
    (define digits (str->digits s))
    (define n (length digits))
    (define memo (make-hash))

    ;; dp(idx, prev-digit, tight, is-leading)
    ;; idx: current digit index
    ;; prev-digit: the digit chosen at idx-1. Use -1 if no previous digit (i.e., for the first actual digit)
    ;; tight: boolean, true if we are restricted by the digits of S.
    ;; is-leading: boolean, true if we are currently placing leading zeros.
    ;; Returns the count of stepping numbers that can be formed from idx to n-1.
    (define (dp idx prev-digit tight is-leading)
      (let* ([state (list idx prev-digit tight is-leading)]
             [memoized-val (hash-ref memo state #f)])
        (if memoized-val
            memoized-val
            (let ([res
                   (cond
                     [(>= idx n)
                      (if is-leading 0 1)] ; If we've reached the end and are still 'is-leading', it means we formed an empty number ("00" for 0), which we don't count as a *new* stepping number here. If not 'is-leading', we've formed a valid positive number.

                     [else
                      (let* ([upper-bound (if tight (list-ref digits idx) 9)]
                             [current-sum 0])
                        (for ([digit (in-range (add1 upper-bound))])
                          (cond
                            [is-leading ; Currently placing leading zeros
                             ;; Option 1: Place a leading zero (digit=0) or just continue leading zeros (digit=0)
                             ;; This counts the "empty" prefix that eventually becomes 0.
                             (set! current-sum (+ current-sum (dp (add1 idx) prev-digit (and tight (= digit upper-bound)) #t)))
                             ;; Option 2: Start the number with a non-zero digit
                             (when (> digit 0)
                               (set! current-sum (+ current-sum (dp (add1 idx) digit (and tight (= digit upper-bound)) #f))))]
                            [else ; Number has already started (is-leading is false)
                             (when (= (abs (- digit prev-digit)) 1)
                               (set! current-sum (+ current-sum (dp (add1 idx) digit (and tight (= digit upper-bound)) #f))))]))
                        current-sum)])])
              (hash-set! memo state res)
              res))))

    ;; Initial call: idx=0, prev-digit=-1 (dummy), tight=true, is-leading=true.
    ;; This will count all stepping numbers from 1 up to S.
    ;; We need to add 1 for the number 0.
    (let ([count-positive-stepping-numbers (dp 0 -1 #t #t)])
      (+ count-positive-stepping-numbers 1))) ; Add 1 for the number 0

  (define (decrement-string s)
    (if (is-zero-str s)
        "-1" ; Special value to indicate no numbers before 0.
        (let* ([len (string-length s)]
               [digits-vec (string->vector s)]) ; Convert to vector for mutable access
          (let loop ([idx (- len 1)])
            (if (< idx 0)
                (error "Should not reach here for positive numbers") ; Should not happen for s > "0"
                (let ([digit-char (vector-ref digits-vec idx)])
                  (if (char=? digit-char #\0)
                      (begin
                        (vector-set! digits-vec idx #\9)
                        (loop (- idx 1)))
                      (begin
                        (vector-set! digits-vec idx (integer->char (- (char->integer digit-char) 1)))
                        (let ([result-str (vector->string digits-vec)])
                          (if (and (> (string-length result-str) 1) (char=? (string-ref result-str 0) #\0))
                              (substring result-str 1) ; Remove leading zero
                              result-str))))))))))

  (define high-count (count-up-to high-str))
  (define low-minus-1-str-val (decrement-string low-str))
  (define low-count
    (if (string=? low-minus-1-str-val "-1")
        0 ; No numbers before 0.
        (count-up-to low-minus-1-str-val)))

  (- high-count low-count))