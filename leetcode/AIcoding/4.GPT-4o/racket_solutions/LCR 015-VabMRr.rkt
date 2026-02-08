(define (find-anagrams s p)
  (define (count-chars str)
    (let loop ((chars (string->list str)) (count (make-vector 26 0)))
      (if (null? chars)
          count
          (begin
            (vector-set! count (- (char->integer (car chars)) (char->integer #\a)) 
                          (+ 1 (vector-ref count (- (char->integer (car chars)) (char->integer #\a)))))
            (loop (cdr chars) count)))))

  (define p-count (count-chars p))
  (define p-len (string-length p))

  (define (matches? a b)
    (for/fold ([result #t]) ([i 0 26])
      (and result (= (vector-ref a i) (vector-ref b i)))))

  (define s-len (string-length s))
  (define result '())

  (define s-count (count-chars (substring s 0 (min p-len s-len))))

  (if (matches? s-count p-count)
      (set! result (cons 0 result)))

  (for ([i (in-range p-len s-len)])
    (begin
      (vector-set! s-count (- (char->integer (string-ref s i)) (char->integer #\a))
                    (+ 1 (vector-ref s-count (- (char->integer (string-ref s i)) (char->integer #\a)))))
      (vector-set! s-count (- (char->integer (string-ref s (- i p-len))) (char->integer #\a))
                    (- (vector-ref s-count (- (char->integer (string-ref s (- i p-len))) (char->integer #\a"))) 1))
      (if (matches? s-count p-count)
          (set! result (cons (- i p-len 1) result)))))

  (reverse result))

(find-anagrams "cbaebabacd" "abc")