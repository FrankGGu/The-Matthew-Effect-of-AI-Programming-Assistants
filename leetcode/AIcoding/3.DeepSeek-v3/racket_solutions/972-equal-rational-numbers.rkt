(define (is-rational-equal s t)
  (define (to-double s)
    (let* ([dot-pos (string-contains s ".")]
           [int-part (if dot-pos (substring s 0 dot-pos) s)]
           [frac-part (if dot-pos (substring s (+ dot-pos 1)) "")]
           [paren-pos (string-contains frac-part "(")]
           [non-repeating (if paren-pos (substring frac-part 0 paren-pos) frac-part)]
           [repeating (if paren-pos (substring frac-part (+ paren-pos 1) "")]
           [repeating (if (string=? repeating "") "0" repeating)]
           [non-repeating (if (string=? non-repeating "") "0" non-repeating)]
           [full-frac (string-append non-repeating 
                                    (let loop ([n 20] [r repeating])
                                      (if (<= n 0) 
                                          ""
                                          (string-append r (loop (- n (string-length r)) r))))]
           [full-frac (substring full-frac 0 (min (string-length full-frac) 20))]
           [full-num (string-append int-part full-frac)]
           [full-len (string-length full-num)]
           [dec-pos (- full-len (string-length full-frac))])
      (exact->inexact (/ (string->number full-num) (expt 10 dec-pos)))))
  (< (abs (- (to-double s) (to-double t))) 1e-10))