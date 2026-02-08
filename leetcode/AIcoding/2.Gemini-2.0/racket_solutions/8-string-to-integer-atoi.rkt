(define (myAtoi s)
  (define (trim-left str)
    (cond
      [(string=? str "") ""]
      [(char-whitespace? (string-ref str 0)) (trim-left (substring str 1))]
      [else str]))

  (define (parse-number str sign)
    (define (string->integer-safe str)
      (let ([result 0]
            [overflow-flag #f])
        (for ([i (in-range (string-length str))])
          (let* ([digit (char->integer (string-ref str i))])
            (cond
              [(<= 48 digit 57)
               (let* ([digit-val (- digit 48)]
                      [new-result (+ (* result 10) digit-val)])
                 (cond
                   [(> new-result (/ (expt 2 31) 1))
                    (set! overflow-flag #t)
                    (set! result (/ (expt 2 31) 1))]
                   [else (set! result new-result)]))]
              [else
               (return result)])))
        (if overflow-flag
            result
            result)))

    (let ([num-str ""])
      (for ([i (in-range (string-length str))])
        (let ([c (string-ref str i)])
          (cond
            [(and (char-numeric? c) (not overflow-flag))
             (set! num-str (string-append num-str (string c)))]
            [else (break)])))
      (if (string=? num-str "")
          0
          (let ([num (string->integer-safe num-str)])
            (cond
              [(and (= sign -1) (> num (expt 2 31)))
               (- (expt 2 31))]
              [(and (= sign 1) (> num (/ (expt 2 31) 1)))
               (/ (expt 2 31) 1)]
              [else (* sign num)])))))

  (let ([trimmed-s (trim-left s)])
    (cond
      [(string=? trimmed-s "") 0]
      [(string=? (substring trimmed-s 0 1) "+") (parse-number (substring trimmed-s 1) 1)]
      [(string=? (substring trimmed-s 0 1) "-") (parse-number (substring trimmed-s 1) -1)]
      [(char-numeric? (string-ref trimmed-s 0)) (parse-number trimmed-s 1)]
      [else 0])))