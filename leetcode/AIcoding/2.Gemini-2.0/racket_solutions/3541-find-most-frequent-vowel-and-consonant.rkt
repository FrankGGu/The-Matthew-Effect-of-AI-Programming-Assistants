(define (find-most-frequent-vowel-and-consonant s)
  (let* ([vowels (string->list "aeiou")]
         [vowel-counts (make-hash)]
         [consonant-counts (make-hash)]
         [_ (for ([c (in-string s)])
              (let ([lower-c (char-downcase c)])
                (if (char-alphabetic? lower-c)
                    (if (member lower-c vowels)
                        (hash-update! vowel-counts lower-c add1 0)
                        (hash-update! consonant-counts lower-c add1 0))
                    #f)))]
         [max-vowel (argmax (lambda (v) (hash-ref vowel-counts v 0)) (hash-keys vowel-counts))]
         [max-consonant (argmax (lambda (c) (hash-ref consonant-counts c 0)) (hash-keys consonant-counts))])
    (list max-vowel max-consonant)))

(define (argmax f lst)
  (if (null? lst)
      #f
      (let loop ([current-max (car lst)]
                 [current-max-val (f (car lst))]
                 [remaining-list (cdr lst)])
        (if (null? remaining-list)
            current-max
            (let ([next-val (f (car remaining-list))])
              (if (> next-val current-max-val)
                  (loop (car remaining-list) next-val (cdr remaining-list))
                  (loop current-max current-max-val (cdr remaining-list))))))))