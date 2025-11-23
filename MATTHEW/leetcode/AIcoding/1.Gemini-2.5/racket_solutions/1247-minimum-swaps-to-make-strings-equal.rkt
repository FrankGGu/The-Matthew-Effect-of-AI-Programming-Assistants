(define (minimum-swaps-to-make-strings-equal s1 s2)
  (let* ([len (string-length s1)]
         [n-xy 0]
         [n-yx 0])
    (for ([i (in-range len)])
      (let ([char1 (string-ref s1 i)]
            [char2 (string-ref s2 i)])
        (when (not (char=? char1 char2))
          (if (char=? char1 #\x)
              (set! n-xy (+ n-xy 1))
              (set! n-yx (+ n-yx 1))))))

    (if (odd? (+ n-xy n-yx))
        -1
        (+ (quotient n-xy 2)
           (quotient n-yx 2)
           (if (and (odd? n-xy) (odd? n-yx))
               2
               0)))))