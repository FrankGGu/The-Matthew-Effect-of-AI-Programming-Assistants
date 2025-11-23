(define (smallest-subsequence s k letter repetition)
  (let loop ([i 0] [stack '()] [count 0])
    (if (= i (string-length s))
        (let ([res (list->string (reverse stack))])
          (if (and (= (string-length res) k)
                   (>= (count-letters res letter) repetition))
              res
              ""))
        (let* ([c (string-ref s i)]
               [remaining (- (string-length s) i)]
               [stack-len (length stack)]
               [new-stack (if (and (> stack-len 0)
                                   (char<? c (car stack))
                                   (< (+ stack-len remaining) (+ k 1)))
                              (let ([new-count (if (char=? (car stack) letter)
                                                  (- count 1)
                                                  count)])
                                (loop i (cdr stack) new-count))
                              stack)]
               [new-stack-len (length new-stack)])
          (if (< new-stack-len k)
              (let ([new-count (if (char=? c letter)
                                  (+ count 1)
                                  count)])
                (loop (+ i 1) (cons c new-stack) new-count))
              (loop (+ i 1) new-stack count))))))

(define (count-letters s letter)
  (let loop ([i 0] [count 0])
    (if (= i (string-length s))
        count
        (loop (+ i 1) (if (char=? (string-ref s i) letter)
                          (+ count 1)
                          count)))))