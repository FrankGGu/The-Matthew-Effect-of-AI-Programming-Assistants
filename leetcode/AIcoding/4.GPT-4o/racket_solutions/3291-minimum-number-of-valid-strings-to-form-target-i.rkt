(define (min-valid-strings target strings)
  (define (can-form? str)
    (define letters (string->list str))
    (define target-letters (string->list target))
    (for/fold ([t (make-hash)] [s (make-hash)])
      ([l letters])
      (hash-set! s l (+ (hash-ref s l 0) 1)))
    (for/fold ([t (make-hash)] [found #t])
      ([l target-letters])
      (if (hash-ref s l 0) 
          (begin
            (hash-set! t l (min (hash-ref t l 0) (hash-ref s l 0)))
            found)
          #f))
    (for/hash ([k (hash-keys t)])
      (if (= (hash-ref t k) 0) 
          (begin (set! found #f) #f) 
          (hash-set! t k (hash-ref t k))))
    found)

  (define (helper str-list)
    (if (null? str-list) 0
        (if (can-form? (car str-list))
            (min (helper (cdr str-list)) (add1 (helper (cdr str-list))))
            (helper (cdr str-list)))))

  (helper strings))

(min-valid-strings "abc" '("a" "b" "c" "ab" "bc" "abc"))