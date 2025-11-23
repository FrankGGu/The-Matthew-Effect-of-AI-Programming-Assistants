(define/contract (maximum-time time)
  (-> string? string?)
  (let* ([chars (string->list time)]
         [h1 (list-ref chars 0)]
         [h2 (list-ref chars 1)]
         [m1 (list-ref chars 3)]
         [m2 (list-ref chars 4)])
    (cond
      [(and (char=? h1 #\?) (char=? h2 #\?)) (set! h1 #\2) (set! h2 #\3)]
      [(char=? h1 #\?)
       (if (<= (char->integer h2) (char->integer #\3))
           (set! h1 #\2)
           (set! h1 #\1))]
      [(char=? h2 #\?)
       (if (<= (char->integer h1) (char->integer #\1))
           (set! h2 #\9)
           (set! h2 #\3))]
      [else (void)])
    (cond
      [(char=? m1 #\?) (set! m1 #\5)]
      [else (void)])
    (cond
      [(char=? m2 #\?) (set! m2 #\9)]
      [else (void)])
    (list->string (list h1 h2 #\: m1 m2)))