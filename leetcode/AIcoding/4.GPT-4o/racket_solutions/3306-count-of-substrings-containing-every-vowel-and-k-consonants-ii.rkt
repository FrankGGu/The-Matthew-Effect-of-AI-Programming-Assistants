(define (count-substrings s k)
  (define vowels (set '(#\a #\e #\i #\o #\u)))
  (define (valid? substring)
    (let loop ((chars (string->list substring))
               (vowel-count 0)
               (consonant-count 0))
      (cond
        ((null? chars) (and (= vowel-count 5) (>= consonant-count k)))
        ((set-member? vowels (car chars))
         (loop (cdr chars) (+ vowel-count 1) consonant-count))
        (else
         (loop (cdr chars) vowel-count (+ consonant-count 1))))))
  (define (count-valid-substrings start end)
    (if (>= end (string-length s))
        0
        (let* ((substring (substring s start end))
               (count (if (valid? substring) 1 0)))
          (+ count (count-valid-substrings start (+ end 1))))))
  (define (count-all-substrings start)
    (if (>= start (string-length s)) 
        0 
        (+ (count-valid-substrings start (+ start 5)) 
           (count-all-substrings (+ start 1)))))
  (count-all-substrings 0))

(count-substrings "your_string" k)