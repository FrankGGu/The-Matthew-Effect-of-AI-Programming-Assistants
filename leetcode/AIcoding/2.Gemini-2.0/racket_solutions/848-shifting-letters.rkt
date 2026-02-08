(define (shifting-letters s shifts)
  (let* ([n (string-length s)]
         [total-shifts (make-vector (add1 n) 0)]
         [_ (for/list ([i (in-range (length shifts))]
                      [shift (in-list shifts)])
              (vector-set! total-shifts 0 (+ (vector-ref total-shifts 0) shift))
              (vector-set! total-shifts (+ i 1) (- (vector-ref total-shifts (+ i 1)) shift)))]
         [prefix-sum (make-vector (add1 n) 0)])
    (let loop ([i 0])
      (if (= i n)
          (let ([result (make-string n)])
            (for ([i (in-range n)])
              (let* ([shift (modulo (vector-ref prefix-sum i) 26)]
                     [char-code (+ (char->integer (string-ref s i)) shift)]
                     [shifted-char-code (if (> char-code (char->integer #\z))
                                              (+ (modulo (- char-code (char->integer #\a)) 26) (char->integer #\a))
                                              char-code)])
                (string-set! result i (integer->char shifted-char-code))))
            result)
          (begin
            (vector-set! prefix-sum i (if (= i 0)
                                            (vector-ref total-shifts i)
                                            (+ (vector-ref prefix-sum (- i 1)) (vector-ref total-shifts i))))
            (loop (+ i 1)))))))