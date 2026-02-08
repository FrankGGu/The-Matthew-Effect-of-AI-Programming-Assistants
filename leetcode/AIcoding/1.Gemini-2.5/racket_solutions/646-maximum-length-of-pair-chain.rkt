(define (find-longest-chain pairs)
  (define n (length pairs))

  (if (zero? n)
      0
      (begin
        ; Sort pairs: first by the second element (b), then by the first element (a).
        ; This ensures that when we iterate, we consider pairs that end earlier first.
        ; If two pairs end at the same point, sorting by 'a' helps maintain a consistent order,
        ; though for the greedy approach, it's less critical than sorting by 'b'.
        (define sorted-pairs
          (sort pairs
                (lambda (p1 p2)
                  (let ((b1 (second p1))
                        (b2 (second p2)))
                    (if (< b1 b2)
                        #t
                        (if (= b1 b2)
                            (< (first p1) (first p2))
                            #f))))))

        ; Initialize the end of the current chain to a value smaller than any possible 'a'.
        ; 'a' values are between -1000 and 1000, so -2001 is a safe choice.
        (define current-chain-end -2001)
        (define chain-length 0)

        ; Iterate through the sorted pairs
        (for ([pair sorted-pairs])
          (define a (first pair))
          (define b (second pair))

          ; If the current pair's first element 'a' is strictly greater than the end of the
          ; previous chain, it means this pair can extend the current chain.
          (when (> a current-chain-end)
            (set! chain-length (+ chain-length 1))
            ; Update the end of the current chain to the second element 'b' of this pair.
            ; We greedily pick the pair that ends earliest to allow more subsequent pairs.
            (set! current-chain-end b)))

        chain-length)))