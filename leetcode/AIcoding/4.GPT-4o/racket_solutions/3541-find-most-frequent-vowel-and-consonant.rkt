(define (most-frequent-vowel-and-consonant s)
  (define vowels '(#\a #\e #\i #\o #\u))
  (define consonants (map (lambda (c) (string->number (string c))) 
                          (filter (lambda (c) (not (member c vowels))) 
                                  (map string->char (string->list (string-downcase s))))))
  (define freq (lambda (lst) (foldl (lambda (x acc) (hash-set! acc x (add1 (hash-ref acc x 0)))) (make-hash) lst)))
  (define vowel-freq (freq (filter (lambda (c) (member c vowels)) (string->list (string-downcase s)))))
  (define consonant-freq (freq (filter (lambda (c) (not (member c vowels))) (string->list (string-downcase s)))))

  (define max-vowel (apply max (hash-values vowel-freq)))
  (define max-consonant (apply max (hash-values consonant-freq)))

  (define most-frequent-vowel (car (filter (lambda (x) (= (hash-ref vowel-freq x) max-vowel)) vowels)))
  (define most-frequent-consonant (car (filter (lambda (x) (= (hash-ref consonant-freq x) max-consonant)) consonants)))

  (list most-frequent-vowel most-frequent-consonant))