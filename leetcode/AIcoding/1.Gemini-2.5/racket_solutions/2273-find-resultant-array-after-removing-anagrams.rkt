(define (remove-anagrams words)
  (define (is-anagram? s1 s2)
    (equal? (list->string (sort (string->list s1) char<?))
            (list->string (sort (string->list s2) char<?))))

  (define (helper remaining-words acc)
    (cond
      ((empty? remaining-words)
       (reverse acc))
      (else
       (let* ((current-word (first remaining-words))
              (prev-word (if (empty? acc) #f (first acc))))
         (if (and prev-word (is-anagram? current-word prev-word))
             (helper (rest remaining-words) acc)
             (helper (rest remaining-words) (cons current-word acc)))))))
  (helper words '()))