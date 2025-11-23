(define/contract (find-original-string typed original)
  (-> string? string? string?)
  (let loop ([i 0] [j 0] [res '()])
    (cond
      [(>= i (string-length typed)) (if (= j (string-length original))
                                        (list->string (reverse res))
                                        "")]
      [(>= j (string-length original)) ""]
      [(char=? (string-ref typed i) (string-ref original j))
       (loop (add1 i) (add1 j) (cons (string-ref typed i) res))]
      [(and (> j 0) (char=? (string-ref typed i) (string-ref original (sub1 j))))
       (loop (add1 i) j (cons (string-ref typed i) res))]
      [else ""])))