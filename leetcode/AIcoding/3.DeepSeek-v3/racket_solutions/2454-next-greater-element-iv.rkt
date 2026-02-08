(define/contract (second-greater-element nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [res (make-list n -1)]
         [s1 '()]
         [s2 '()]
         [temp '()])
    (for ([i (in-range n)])
      (let ([num (list-ref nums i)])
        (while (and (not (null? s2)) (< (car (car s2)) num))
          (let ([idx (cdr (car s2))])
            (list-set! res idx num)
            (set! s2 (cdr s2)))
        (set! temp '())
        (while (and (not (null? s1)) (< (car (car s1)) num))
          (set! temp (cons (car s1) temp))
          (set! s1 (cdr s1)))
        (while (not (null? temp))
          (set! s2 (cons (car temp) s2))
          (set! temp (cdr temp))
        (set! s1 (cons (cons num i) s1))))
    res))