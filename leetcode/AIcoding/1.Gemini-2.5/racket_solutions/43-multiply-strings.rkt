#lang racket

(define (multiply-strings num1 num2)
  (if (or (string=? num1 "0") (string=? num2 "0"))
      "0"
      (let* ([len1 (string-length num1)]
             [len2 (string-length num2)]
             [result (make-vector (+ len1 len2) 0)])

        (for ([i (range (- len1 1) -1 -1)])
          (let ([d1 (- (char->integer (string-ref num1 i)) (char->integer #\0))])
            (for ([j (range (- len2 1) -1 -1)])
              (let ([d2 (- (char->integer (string-ref num2 j)) (char->integer #\0))])
                (let* ([p (* d1 d2)]
                       [pos1 (+ i j)]
                       [pos2 (+ i j 1)]
                       [sum (+ p (vector-ref result pos2))])
                  (vector-set! result pos2 (modulo sum 10))
                  (vector-set! result pos1 (+ (vector-ref result pos1) (quotient sum 10))))))))

        (let loop ([k 0])
          (cond
            [(< k (vector-length result))
             (if (= (vector-ref result k) 0)
                 (loop (+ k 1))
                 (let ([sb (string-builder)])
                   (for ([idx k (vector-length result)])
                     (string-builder-add-char! sb (integer->char (+ (vector-ref result idx) (char->integer #\0)))))
                   (string-builder-build sb)))]
            [else "0"])))))