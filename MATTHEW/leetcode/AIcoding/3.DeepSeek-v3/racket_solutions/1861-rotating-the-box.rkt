(define/contract (rotate-the-box box)
  (-> (listof (listof char?)) (listof (listof char?))
  (let* ([m (length box)]
         [n (if (zero? m) 0 (length (car box)))]
         [rotated (make-list n (make-list m #\.))])
    (for ([i (in-range m)])
      (let ([row (list-ref box i)]
            [obstacle-pos n])
        (for ([j (in-range (sub1 n) -1 -1)])
          (let ([cell (list-ref row j)])
            (cond
              [(char=? cell #\#)
               (set! obstacle-pos (sub1 obstacle-pos))
               (list-set! (list-ref rotated (- n j 1)) i #\#)]
              [(char=? cell #\*)
               (set! obstacle-pos j)
               (list-set! (list-ref rotated (- n j 1)) i #\*)]
              [else void])))))
    rotated))