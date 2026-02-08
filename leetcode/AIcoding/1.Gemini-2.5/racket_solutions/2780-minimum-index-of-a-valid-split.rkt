(define (minimum-index-of-valid-split nums-list)
  (call-with-current-continuation
   (lambda (return)
     (define nums (list->vector nums-list))
     (define n (vector-length nums))

     (when (< n 2)
       (return -1))

     (define counts (make-hash))
     (for ([x (in-vector nums)])
       (hash-update! counts x add1 0))

     (define dominant-val #f)
     (define total-dominant-count 0)
     (hash-for-each (lambda (val count)
                      (when (> count (/ n 2))
                        (set! dominant-val val)
                        (set! total-dominant-count count)))
                    counts)

     (unless dominant-val
       (return -1))

     (define current-left-dominant-count 0)

     (define result
       (for/first ([i (in-range (- n 1))])
         (define current-element (vector-ref nums i))

         (when (equal? current-element dominant-val)
           (set! current-left-dominant-count (+ current-left-dominant-count 1)))

         (define left-len (+ i 1))
         (define right-len (- n left-len))
         (define right-dominant-count (- total-dominant-count current-left-dominant-count))

         (when (and (> (* current-left-dominant-count 2) left-len)
                    (> (* right-dominant-count 2) right-len))
           i)
         #:else #f))

     (if (number? result)
         result
         -1))))