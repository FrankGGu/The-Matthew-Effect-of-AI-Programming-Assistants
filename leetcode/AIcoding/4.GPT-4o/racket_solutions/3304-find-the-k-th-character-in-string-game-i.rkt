(define (findKthCharacter s k)
  (define (helper str idx)
    (if (>= idx (string-length str))
        #f
        (if (= (string-ref str idx) #\?)
            (helper str (+ idx 1))
            (string-ref str idx))))
  (helper s k))