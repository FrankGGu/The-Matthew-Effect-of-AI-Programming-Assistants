(define (统计目标成绩的出现次数 nums target)
  (define (find-first nums target)
    (let loop ((low 0) (high (- (length nums) 1)) (first-idx -1))
      (if (> low high)
          first-idx
          (let* ((mid (+ low (quotient (- high low) 2)))
                 (mid-val (list-ref nums mid)))
            (cond
              ((= mid-val target)
               (loop low (- mid 1) mid))
              ((< mid-val target)
               (loop (+ mid 1) high first-idx))
              (else
               (loop low (- mid 1) first-idx)))))))

  (define (find-last nums target)
    (let loop ((low 0) (high (- (length nums) 1)) (last-idx -1))
      (if (> low high)
          last-idx
          (let* ((mid (+ low (quotient (- high low) 2)))
                 (mid-val (list-ref nums mid)))
            (cond
              ((= mid-val target)
               (loop (+ mid 1) high mid))
              ((< mid-val target)
               (loop (+ mid 1) high last-idx))
              (else
               (loop low (- mid 1) last-idx)))))))

  (let* ((first (find-first nums target))
         (last (find-last nums target)))
    (if (= first -1)
        0
        (+ (- last first) 1))))