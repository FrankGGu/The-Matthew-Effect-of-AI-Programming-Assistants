(define (canConstruct ransomNote magazine)
  (define (count-letters str)
    (foldl (lambda (ch acc)
              (hash-set! acc ch (add1 (hash-ref acc ch 0)))
              acc)
            (make-hash)
            str))
  (define ransom-count (count-letters ransomNote))
  (define magazine-count (count-letters magazine))
  (for/sum ([ch (hash-keys ransom-count)])
    (if (>= (hash-ref magazine-count ch 0) (hash-ref ransom-count ch 0))
        0
        1)) = 0)

(define (main)
  (let ([ransomNote (read-line)]
        [magazine (read-line)])
    (display (canConstruct ransomNote magazine))))

(main)