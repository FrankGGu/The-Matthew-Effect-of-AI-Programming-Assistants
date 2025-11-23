(define (find132pattern nums)
  (define n (length nums))
  (if (< n 3)
      #f
      (let ((nums-vec (list->vector nums)))
        (define neg-infinity -1000000001) ; Smallest possible value for nums[i] is -10^9

        (let loop ((j (- n 1))
                   (k-val neg-infinity) ; This k-val is the largest nums[k] found so far that is less than some nums[j']
                   (s '()))             ; s is the stack of potential nums[j] values, in decreasing order

          (if (< j 0)
              #f ; No pattern found
              (let ((current-num (vector-ref nums-vec j)))
                (if (< current-num k-val)
                    #t ; Found a pattern: current-num is nums[i], k-val is nums[k], and the element that caused k-val to be set was nums[j']
                    (let-values (((new-k-val new-s)
                                  (let pop-stack ((temp-s s) (current-max-k k-val))
                                    (if (and (not (null? temp-s))
                                             (> current-num (car temp-s)))
                                        (pop-stack (cdr temp-s) (car temp-s)) ; Pop and update max-k
                                        (values current-max-k temp-s))))) ; Return the max-k found and the remaining stack
                      ; After popping, push current-num onto the (possibly modified) stack
                      (loop (- j 1) new-k-val (cons current-num new-s)))))))))