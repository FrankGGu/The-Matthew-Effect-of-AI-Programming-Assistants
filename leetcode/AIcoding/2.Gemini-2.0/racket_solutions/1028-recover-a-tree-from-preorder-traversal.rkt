(define (recover-from-preorder s)
  (define (helper s depth)
    (if (empty? s)
        (values null s))
    (define (count-dashes str)
      (let loop ([str str] [count 0])
        (cond [(empty? str) count]
              [(char=? (first str) #\-) (loop (rest str) (add1 count))]
              [else count])))
    (define dashes (count-dashes s))
    (if (< dashes depth)
        (values null s)
        (let* ([num-str (substring s dashes (or (string-index s #\-) (string-length s)))]
               [num (string->number num-str)])
          (define current-node (list num null null))
          (define-values (left-subtree remaining-s) (helper (substring s (+ dashes (string-length num-str)) (string-length s)) (add1 depth)))
          (define-values (right-subtree final-s) (helper remaining-s (add1 depth)))
          (values (list num left-subtree right-subtree) final-s)))))

  (define-values (tree remaining-s) (helper s 0))
  tree)