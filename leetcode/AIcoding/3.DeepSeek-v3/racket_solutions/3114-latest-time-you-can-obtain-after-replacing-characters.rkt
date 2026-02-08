(define (maximum-time time)
  (let ([chars (string->list time)])
    (list->string
     (for/list ([i (in-range 5)])
       (case i
         [(0) (if (char=? (list-ref chars 1) #\?)
                  (if (char=? (list-ref chars 0) #\?)
                      #\2
                      (if (char<=? (list-ref chars 0) #\1)
                          #\9
                          #\1))
                  (if (char=? (list-ref chars 0) #\?)
                      (if (char<=? (list-ref chars 1) #\3)
                          #\2
                          #\1)
                      (list-ref chars 0)))]
         [(1) (if (char=? (list-ref chars 0) #\2)
                  (if (char=? (list-ref chars 1) #\?)
                      #\3
                      (list-ref chars 1))
                  (if (char=? (list-ref chars 1) #\?)
                      #\9
                      (list-ref chars 1)))]
         [(2) #\:]
         [(3) (if (char=? (list-ref chars 3) #\?)
                  #\5
                  (list-ref chars 3))]
         [(4) (if (char=? (list-ref chars 4) #\?)
                  #\9
                  (list-ref chars 4))])))))