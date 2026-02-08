(define (mirror-score s)
  (define mirror-letters '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z))
  (define mirror-values (map (lambda (x) (list x (+ 1 (index-of mirror-letters x)))) mirror-letters))
  (define score (foldl (lambda (char acc)
                          (+ acc (or (cdr (assoc char mirror-values)) 0)))
                        0
                        (string->list (string-downcase s))))
  score)

(define (find-mirror-score s)
  (mirror-score s))