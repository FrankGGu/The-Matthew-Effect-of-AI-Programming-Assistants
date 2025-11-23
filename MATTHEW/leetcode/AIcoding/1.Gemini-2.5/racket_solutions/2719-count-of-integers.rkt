#lang racket

(define MOD 1000000007)

(define (char->int c)
  (- (char->ascii c) (char->ascii #\0)))

(define (int->char i)
  (integer->char (+ (char->ascii #\0) i)))

(define (subtract-one num-str)
  (define n (string-length num-str))
  (define chars (string->list num-str)) ; Convert to mutable list of characters

  (let loop ([i (- n 1)])
    (if (< i 0)
        "0" ; If we reach the beginning and still need to borrow (e.g., "1" -> "0")
        (let* ((digit (char->int (list-ref chars i))))
          (if (> digit 0)
              (begin
                (list-set! chars i (int->char (- digit 1)))
                (let ([result (list->string chars)])
                  (if (and (= (char->int (string-ref result 0)) 0) (> (string-length result) 1))
                      (substring result 1 (string-length result)) ; Remove leading zero if it's not "0"
                      result)))
              (begin ; digit is 0, need to borrow
                (list-set! chars i #\9)
                (loop (- i 1))))))))

(define (solve s min-sum max-sum)
  (define n (string-length s))
  ; dp[idx][current-sum][tight][is-started]
  ; idx: current digit position (0 to n-1)
  ; current-sum: sum of digits placed so far (excluding leading zeros if not started)
  ; tight: boolean, true if we are restricted by digits of s
  ; is-started: boolean, true if we have placed at least one non-zero digit
  (define memo (make-hash))

  (define (dp idx current-sum tight is-started)
    (cond
      ((> current-sum max-sum) 0) ; Optimization: if sum already too large, no need to continue
      ((= idx n) (if (and is-started (>= current-sum min-sum)) 1 0)) ; Base case: all digits placed
                                                                      ; Only count if it's a valid positive number (is-started is true)
      (else
       (define state (list idx current-sum tight is-started))
       (hash-ref memo state
                 (lambda ()
                   (let* ((limit (if tight (char->int (string-ref s idx)) 9))
                          (ans 0))
                     (for ([digit (in-range (+ limit 1))]) ; Iterate digit from 0 to limit
                       (let* ((new-sum (if (and (not is-started) (= digit 0))
                                           0 ; Still placing leading zeros, sum remains 0
                                           (+ current-sum digit)))
                              (new-is-started (or is-started (> digit 0))))
                         (when (<= new-sum max-sum) ; Optimization: check sum before recursion
                           (set! ans
                                 (modulo (+ ans
                                            (dp (+ idx 1)
                                                new-sum
                                                (and tight (= digit limit))
                                                new-is-started))
                                         MOD))))
                     (hash-set! memo state ans)
                     ans))))))

  ; Initial call: start from index 0, sum 0, tight true (restricted by 's'), not started yet
  (dp 0 0 #t #f))

(define (count-integers num1 num2 min_sum max_sum)
  (define ans2 (solve num2 min_sum max_sum))
  (define num1-minus-1 (subtract-one num1))
  (define ans1-minus-1 (solve num1-minus-1 min_sum max_sum))

  ; Ensure result is non-negative
  (modulo (+ (- ans2 ans1-minus-1) MOD) MOD))