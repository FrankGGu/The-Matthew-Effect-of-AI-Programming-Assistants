#lang racket

(define (find-value-of-mysterious-function-closest-to-target arr target)
  (let* ([n (vector-length arr)]
         [min-diff (abs (- (vector-ref arr 0) target))]
         [current-ands (list (vector-ref arr 0))]) ; Stores distinct AND values, in decreasing order

    (for ([i (in-range 1 n)])
      (let* ([current-num (vector-ref arr i)]
             ; Generate all possible AND values for the current 'r' (index i)
             ; These are (val & current-num) for previous ranges, and current-num itself.
             [next-ands-raw (append (for/list ([val current-ands])
                                       (bitwise-and val current-num))
                                    (list current-num))]
             ; Sort these values in descending order to easily remove duplicates
             [sorted-next-ands (sort next-ands-raw >)])

        ; Efficiently create a new list of unique values in descending order
        (let loop ([remaining sorted-next-ands]
                   [acc '()]
                   [last-val -1]) ; -1 as a sentinel, assuming non-negative array values
          (cond
            [(empty? remaining)
             (set! current-ands (reverse acc))] ; Reverse to get descending order
            [else
             (let ([val (car remaining)])
               (if (not (= val last-val))
                   (loop (cdr remaining) (cons val acc) val)
                   (loop (cdr remaining) acc last-val)))]))

        ; Update min-diff with the newly found distinct AND values
        (for ([val current-ands])
          (set! min-diff (min min-diff (abs (- val target)))))))

    min-diff))