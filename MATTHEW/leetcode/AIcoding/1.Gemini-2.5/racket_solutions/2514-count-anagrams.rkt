#lang racket

(define (increment-hash-count! h key)
  (hash-update! h key (lambda (v) (+ v 1)) 0))

(define (decrement-hash-count! h key)
  (let ([current-count (hash-ref h key 0)])
    (when (> current-count 0)
      (hash-set! h key (- current-count 1)))
    (when (= current-count 1)
      (hash-remove! h key))))

(define (char-freq-map s)
  (let ([freq (make-hash)])
    (for ([char (string->list s)])
      (increment-hash-count! freq char))
    freq))

(define (hash-equal? h1 h2)
  (and (= (hash-count h1) (hash-count h2))
       (for/and ([k v (in-hash h1)])
         (and (hash-has-key? h2 k) (= (hash-ref h2 k) v)))))

(define (count-anagrams s p)
  (let* ([n (string-length s)]
         [k (string-length p)])
    (if (> k n) 0
        (let* ([p-freq (char-freq-map p)]
               [current-window-freq (make-hash)]
               [count 0])

          (for ([i (in-range k)])
            (increment-hash-count! current-window-freq (string-ref s i)))

          (when (hash-equal? p-freq current-window-freq)
            (set! count (+ count 1)))

          (for ([i (in-range 1 (- n k) #t)])
            (let ([char-out (string-ref s (- i 1))]
                  [char-in (string-ref s (+ i k -1))])

              (decrement-hash-count! current-window-freq char-out)
              (increment-hash-count! current-window-freq char-in))

            (when (hash-equal? p-freq current-window-freq)
              (set! count (+ count 1))))
          count))))