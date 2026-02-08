(define/contract (find-the-longest-substring s)
  (-> string? exact-integer?)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define n (string-length s))
  (define status (make-hash '((0 . -1))))
  (define (char->mask c)
    (cond
      [(set-member? vowels c) (case c
                                [(#\a) 1]
                                [(#\e) 2]
                                [(#\i) 4]
                                [(#\o) 8]
                                [(#\u) 16])]
      [else 0]))
  (let loop ([i 0] [mask 0] [res 0])
    (if (= i n)
        res
        (let* ([c (string-ref s i)]
               [new-mask (bitwise-xor mask (char->mask c))])
          (if (hash-has-key? status new-mask)
              (loop (+ i 1) new-mask (max res (- i (hash-ref status new-mask))))
              (begin
                (hash-set! status new-mask i)
                (loop (+ i 1) new-mask res)))))))