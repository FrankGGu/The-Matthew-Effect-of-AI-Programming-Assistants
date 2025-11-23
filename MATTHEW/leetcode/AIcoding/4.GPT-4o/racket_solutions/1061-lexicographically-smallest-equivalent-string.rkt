(define (smallestEquivalentString s1 s2 baseStr)
  (define parent (make-vector 26 (lambda (i) i)))

  (define (find x)
    (if (= (vector-ref parent x) x)
        x
        (let ((root (find (vector-ref parent x))))
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (define rootX (find x))
    (define rootY (find y))
    (if (< rootX rootY)
        (vector-set! parent rootY rootX)
        (vector-set! parent rootX rootY)))

  (for-each (lambda (i) (union (- (char->integer (string-ref s1 i)) (char->integer #\a)) 
                                 (- (char->integer (string-ref s2 i)) (char->integer #\a))))
            (range (string-length s1)))

  (define result "")
  (for-each (lambda (c)
              (define index (- (char->integer c) (char->integer #\a)))
              (define root (find index))
              (set! result (string-append result (string (integer->char (+ root (char->integer #\a)))))))
            (string->list baseStr))

  result)

(define (findEquivalentString s1 s2 baseStr)
  (smallestEquivalentString s1 s2 baseStr))