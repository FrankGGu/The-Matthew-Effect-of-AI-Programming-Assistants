(define (get-freq-array s)
  (let ((freq (make-vector 26 0)))
    (for-each
     (lambda (char)
       (let ((idx (- (char->integer char) (char->integer #\a))))
         (vector-set! freq idx (+ (vector-ref freq idx) 1))))
     (string->list s))
    freq))

(define (calc-min-changes-less-than freq1 freq2 len1 len2)
  (let ((min-changes (add1 (+ len1 len2)))) ; Initialize with a value larger than any possible changes
    (for ((k (in-range 0 25))) ; k represents character 'a' + k, up to 'y' (index 24)
      (let* ((changes-for-1 (for/sum ((j (in-range (add1 k) 26)))
                              (vector-ref freq1 j)))
             (changes-for-2 (for/sum ((j (in-range 0 (add1 k))))
                              (vector-ref freq2 j))))
        (set! min-changes (min min-changes (+ changes-for-1 changes-for-2)))))
    min-changes))

(define (min-characters-to-satisfy-conditions a b)
  (let* ((len-a (string-length a))
         (len-b (string-length b))
         (freq-a (get-freq-array a))
         (freq-b (get-freq-array b)))

    ;; Condition 1: Every character in a is strictly less than every character in b.
    (let ((res1 (calc-min-changes-less-than freq-a freq-b len-a len-b)))

      ;; Condition 2: Every character in b is strictly less than every character in a.
      (let ((res2 (calc-min-changes-less-than freq-b freq-a len-b len-a)))

        ;; Condition 3: Both a and b consist of only one distinct character.
        (let ((res3 (let ((min-changes-cond3 (add1 (+ len-a len-b))))
                      (for ((p (in-range 0 26))) ; p represents char 'a' + p, up to 'z' (index 25)
                        (let ((changes (+ (- len-a (vector-ref freq-a p))
                                          (- len-b (vector-ref freq-b p)))))
                          (set! min-changes-cond3 (min min-changes-cond3 changes))))
                      min-changes-cond3)))
          (min res1 res2 res3))))))