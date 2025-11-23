(define (uncommon-from-sentences s1 s2)
  (define (string->list str)
    (string-split str " "))

  (define (count-words lst)
    (let ((counts (make-hash)))
      (for-each (lambda (word)
                  (hash-update! counts word (lambda (v) (+ v 1)) 1))
                lst)
      counts))

  (define words1 (string->list s1))
  (define words2 (string->list s2))

  (define counts1 (count-words words1))
  (define counts2 (count-words words2))

  (define uncommon '())
  (for-each (lambda (word)
              (if (and (not (hash-has-key? counts2 word)) (= (hash-ref counts1 word) 1))
                  (set! uncommon (cons word uncommon))))
            words1)
  (for-each (lambda (word)
              (if (and (not (hash-has-key? counts1 word)) (= (hash-ref counts2 word) 1))
                  (set! uncommon (cons word uncommon))))
            words2)

  uncommon)