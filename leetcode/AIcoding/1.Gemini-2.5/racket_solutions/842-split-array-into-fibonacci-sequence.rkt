#lang racket

(define (split-into-fibonacci s)
  (define s-len (string-length s))
  (define MAX_INT 2147483647) ; 2^31 - 1

  (define (backtrack index current-fib-sequence)
    ;; Base case: Reached the end of the input string
    (if (= index s-len)
        ;; A valid Fibonacci-like sequence must have at least three elements
        (if (>= (length current-fib-sequence) 3)
            current-fib-sequence ; Found a valid sequence
            #f)                  ; Not enough elements, so this path is invalid

        ;; Recursive step: Try to form the next number starting from 'index'
        ;; 'j' is the exclusive end index for the substring representing the current candidate number
        (let loop ([j (+ index 1)])
          (cond
            ;; If 'j' exceeds the string length, no more candidates can be formed from 'index'
            [(> j s-len) #f] 

            [else
             (let* ([sub-str (substring s index j)]
                    [sub-len (string-length sub-str)])

               ;; Condition 1: Check for leading zero. A number cannot start with '0' unless it is '0' itself.
               (if (and (> sub-len 1) (char=? (string-ref sub-str 0) #\0))
                   (loop (+ j 1)) ; Invalid candidate, try a longer one (equivalent to 'continue' in imperative loops)

                   ;; Proceed to parse the number from the substring
                   (let ([num (string->number sub-str)])
                     ;; Condition 2: Check for integer overflow (numbers must be less than 2^31)
                     (if (> num MAX_INT)
                         (loop (+ j 1)) ; Invalid candidate, try a longer one (equivalent to 'continue')

                         ;; Apply the Fibonacci sequence rules
                         (cond
                           ;; Case A: If fewer than two numbers are in the sequence, just add the current number
                           ;; and recurse to find the next one.
                           [(< (length current-fib-sequence) 2)
                            (let ([result (backtrack j (append current-fib-sequence (list num)))])
                              (if result
                                  result         ; If a complete sequence is found, propagate it upwards
                                  (loop (+ j 1)))))] ; No sequence found from this path, try next candidate

                           ;; Case B: If at least two numbers are present, check the Fibonacci property.
                           [else
                            (let* ([num1 (list-ref current-fib-sequence (- (length current-fib-sequence) 2))]
                                   [num2 (list-ref current-fib-sequence (- (length current-fib-sequence) 1))]
                                   [expected-sum (+ num1 num2)])

                              (cond
                                ;; If the current number is less than the expected sum, it's too small.
                                ;; Try a longer candidate number from the current 'index'.
                                [(< num expected-sum)
                                 (loop (+ j 1))]
                                ;; If the current number is greater than the expected sum, it's too large.
                                ;; Since subsequent candidates will only be larger, no valid sequence can be
                                ;; formed from this 'index' with the current 'current-fib-sequence'.
                                ;; (Equivalent to 'break' and returning #f for this call)
                                [(> num expected-sum)
                                 #f]
                                ;; If the current number matches the expected sum, it's a valid Fibonacci step.
                                ;; Add it to the sequence and recurse.
                                [else ; num = expected-sum
                                 (let ([result (backtrack j (append current-fib-sequence (list num)))])
                                   (if result
                                       result ; If a complete sequence is found, propagate it
                                       ;; If this path didn't lead to a solution, and 'num' was exactly
                                       ;; 'expected-sum', then no other candidate from this 'index' can work.
                                       #f)))])))])))])))

  ;; Start the backtracking process from the beginning of the string with an empty sequence
  (backtrack 0 '()))