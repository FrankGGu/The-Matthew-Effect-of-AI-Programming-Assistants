(define (find-maximum-sequence-value nums)
  (let* ([n (length nums)]
         [nums-list (list->vector nums)])
    (if (< n 2)
        0
        (let loop ([i 0]
                   [max-val 0]
                   [max-so-far (vector-ref nums-list 0)])
          (if (= i n)
              max-val
              (let* ([current-num (vector-ref nums-list i)]
                     [new-max-val (if (> i 0)
                                      (max max-val (- max-so-far current-num))
                                      max-val)]
                     [new-max-so-far (max max-so-far current-num)])
                (loop (+ i 1) new-max-val new-max-so-far)))))))