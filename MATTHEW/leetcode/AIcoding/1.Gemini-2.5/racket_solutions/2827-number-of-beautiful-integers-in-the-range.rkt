(define (number-of-beautiful-integers low high k)

  (define (solve n k-val)
    (if (= n 0)
        0
        (let* ([s (number->string n)]
               [len (string-length s)]
               [digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list s))]
               [memo (make-hash)])

          (define (dp pos tight? is-leading-zero? even-cnt odd-cnt current-mod)
            (let ([state (list pos tight? is-leading-zero? even-cnt odd-cnt current-mod)])
              (hash-ref! memo state
                         (lambda ()
                           (cond
                             [(>= pos len)
                              (if is-leading-zero?
                                  0 ; Empty number or only leading zeros, not a positive number
                                  (if (and (= even-cnt odd-cnt) (= current-mod 0))
                                      1
                                      0))]
                             [else
                              (let* ([upper-bound (if tight? (list-ref digits pos) 9)]
                                     [count 0])
                                (for ([digit (in-range (+ upper-bound 1))])
                                  (let* ([new-tight? (and tight? (= digit upper-bound))]
                                         [new-is-leading-zero? (and is-leading-zero? (= digit 0))])
                                    (if new-is-leading-zero?
                                        ; If still placing leading zeros, counts and mod remain 0
                                        (set! count (+ count (dp (+ pos 1) new-tight? #t 0 0 0)))
                                        ; Otherwise, update counts and mod
                                        (let* ([new-even-cnt (if (even? digit) (+ even-cnt 1) even-cnt)]
                                               [new-odd-cnt (if (odd? digit) (+ odd-cnt 1) odd-cnt)]
                                               [new-current-mod (remainder (+ (* current-mod 10) digit) k-val)])
                                          (set! count (+ count (dp (+ pos 1) new-tight? #f new-even-cnt new-odd-cnt new-current-mod)))))))
                                count)))))))
          (dp 0 #t #t 0 0 0))))

  (- (solve high k) (solve (- low 1) k)))