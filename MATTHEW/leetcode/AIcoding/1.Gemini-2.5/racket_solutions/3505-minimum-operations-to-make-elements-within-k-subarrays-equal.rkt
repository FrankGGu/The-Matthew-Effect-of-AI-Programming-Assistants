#lang racket

(define (min-operations nums-list k)
  (define n (length nums-list))

  (cond
    ; If k=1, every subarray of length 1 already has all elements equal.
    ; No operations are needed.
    [(= k 1) 0]

    ; If k > 1, the condition "for every subarray of length k, all its elements are equal"
    ; implies that all elements in the entire array must be equal.
    ;
    ; For example, consider an array [a, b, c, d, e] and k=3.
    ; Subarray [a, b, c] must have equal elements => a = b = c.
    ; Subarray [b, c, d] must have equal elements => b = c = d.
    ; Subarray [c, d, e] must have equal elements => c = d = e.
    ; From a=b=c and b=c=d, we get a=b=c=d.
    ; From c=d=e and a=b=c=d, we get a=b=c=d=e.
    ; This logic extends for any k > 1 and any n.
    ;
    ; The minimum number of operations to make all elements in an array equal
    ; is (total number of elements) - (frequency of the most frequent element).
    [else
     (define freq-map (make-hash))

     ; Populate frequency map
     (for ([x (in-list nums-list)])
       (hash-update! freq-map x add1 0)) ; Increment count for x, default to 0 if not present

     (define max-freq 0)

     ; Find the maximum frequency
     (hash-for-each
      freq-map
      (lambda (key val)
        (when (> val max-freq)
          (set! max-freq val))))

     ; Calculate minimum operations
     (- n max-freq))]))