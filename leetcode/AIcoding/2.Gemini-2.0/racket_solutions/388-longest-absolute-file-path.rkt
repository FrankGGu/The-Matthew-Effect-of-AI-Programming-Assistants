(define (lengthLongestPath input)
  (let loop ([lines (string-split input "\n")]
             [stack '()]
             [max-len 0])
    (if (null? lines)
        max-len
        (let* ([line (car lines)]
               [level (count #\tab (string->list line))]
               [name (substring line level (string-length line))]
               [len (string-length name)]
               [new-stack (if (<= level (length stack))
                              (take stack level)
                              stack)]
               [path-len (+ len (if (null? new-stack) 0 (+ 1 (apply + new-stack))))])
          (if (string-contains? name ".")
              (loop (cdr lines) new-stack (max max-len path-len))
              (loop (cdr lines) (append new-stack (list path-len)) max-len))))))