(define (count-vowels s)
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (let loop ([i 0] [count 0])
    (if (>= i (string-length s))
        count
        (loop (+ i 1) 
              (if (set-member? vowels (string-ref s i))
                  (+ count 1)
                  count))))

(define (vowels-game s)
  (let ([vowels-count (count-vowels s)])
    (if (even? vowels-count)
        "B"
        "A")))