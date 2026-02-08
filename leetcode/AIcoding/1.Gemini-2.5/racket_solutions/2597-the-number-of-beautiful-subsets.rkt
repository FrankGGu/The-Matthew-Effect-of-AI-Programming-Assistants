#lang racket

(define (beautiful-subsets nums k)
  (let* ([n (vector-length nums)]
         [sorted-nums (vector-sort < nums)])

    (define (backtrack index current-freq-map)
      (if (= index n)
          ;; Base case: Reached the end of the array.
          ;; If the current-freq-map is not empty, it's a beautiful subset.
          (if (hash-empty? current-freq-map) 0 1)
          ;; Recursive step
          (let* ([num (vector-ref sorted-nums index)]
                 ;; Option 1: Exclude the current number
                 [count-without (backtrack (+ index 1) current-freq-map)])

            ;; Option 2: Include the current number, if possible
            (let ([can-include? #t])
              ;; Check if num - k or num + k is already in the subset
              (when (> (hash-ref current-freq-map (- num k) 0) 0)
                (set! can-include? #f))
              (when (> (hash-ref current-freq-map (+ num k) 0) 0)
                (set! can-include? #f))

              (if can-include?
                  (begin
                    ;; Add num to the frequency map
                    (hash-update! current-freq-map num add1 0)
                    (let ([count-with (backtrack (+ index 1) current-freq-map)])
                      ;; Backtrack: remove num from the frequency map
                      (hash-update! current-freq-map num sub1)
                      (+ count-without count-with)))
                  ;; Cannot include num
                  count-without)))))

    ;; Start the backtracking from index 0 with an empty frequency map
    (backtrack 0 (make-hash))))