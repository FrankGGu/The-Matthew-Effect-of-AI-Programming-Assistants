(define (numberOfWeakCharacters properties)
  (define sorted-properties 
    (sort properties 
          (lambda (a b) (or (> (first a) (first b)) 
                            (and (= (first a) (first b)) 
                                 (< (second a) (second b))))))
    )
  (define max-defense 0)
  (define weak-characters 0)
  (for-each (lambda (p)
              (if (> (second p) max-defense)
                  (set! max-defense (second p))
                  (set! weak-characters (+ weak-characters 1))))
            sorted-properties)
  weak-characters)

(numberOfWeakCharacters '((5 5) (6 3) (3 6)))