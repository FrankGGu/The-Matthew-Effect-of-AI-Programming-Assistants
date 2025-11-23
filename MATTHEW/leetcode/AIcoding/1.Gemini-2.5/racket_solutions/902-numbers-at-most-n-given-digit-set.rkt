#lang racket

(define (at-most-n-given-digit-set digits n)
  (let* ([n-str (number->string n)]
         [L (string-length n-str)]
         [digits-int (map (lambda (s) (string->number s)) digits)]
         [K (length digits-int)])

    ;; Part 1: Numbers with fewer digits than N
    ;; Calculate count of numbers with length 1 to L-1.
    (define count-less-digits
      (for/sum ([l (in-range 1 L)])
        (expt K l)))

    ;; Part 2: Numbers with the same number of digits as N
    ;; This function calculates the count of numbers of length L that are <= N,
    ;; assuming the prefix up to `i-1` matches N's prefix.
    ;; `i` is the current digit position (0-indexed) being processed.
    (define (count-length-L-from-prefix-match i)
      (if (= i L)
          ;; Base case: If we have processed all L digits and maintained a prefix match,
          ;; it means N itself is a valid number.
          1
          (let* ([n-digit-char (string-ref n-str i)]
                 [n-digit-val (- (char->integer n-digit-char) (char->integer #\0))]
                 [current-pos-count 0] ; Accumulator for numbers formed at this position
                 [found-exact-match #f]) ; Flag to indicate if n-digit-val is present in digits-int

            ;; Iterate through available digits
            (for ([d digits-int])
              (cond
                [(< d n-digit-val)
                 ;; If digit 'd' is smaller than N's digit at current position 'i',
                 ;; we can place 'd' here. The remaining (L - 1 - i) positions can be filled
                 ;; with any of the K available digits.
                 (set! current-pos-count (+ current-pos-count (expt K (- L 1 i))))]
                [(= d n-digit-val)
                 ;; If digit 'd' matches N's digit, we can continue to form N's prefix.
                 ;; The contribution from this path will be determined by a recursive call.
                 (set! found-exact-match #t)]
                [(> d n-digit-val)
                 ;; If digit 'd' is larger, we cannot use it or any subsequent digits
                 ;; (since digits-int is sorted) without exceeding N. So, we stop.
                 (break)])) ; 'break' exits the 'for' loop

            (if found-exact-match
                ;; If an exact match for N's digit was found, add the count from the
                ;; recursive call for the next position to the current count.
                (+ current-pos-count (count-length-L-from-prefix-match (+ i 1)))
                ;; Otherwise, no exact match was found, so we cannot form a prefix
                ;; that matches N's. We just return the numbers already counted
                ;; (those that were strictly less than N's prefix up to this point).
                current-pos-count))))

    ;; The total count is the sum of numbers with fewer digits and numbers with the same length.
    (+ count-less-digits (count-length-L-from-prefix-match 0))))