(define (orderly-queue s k)
  (if (= k 1)
      (let* ([n (string-length s)]
             [min-s s]
             [current-s s])
        (for ([i (in-range n)])
          (set! current-s (string-append (substring current-s 1 n) (substring current-s 0 1)))
          (when (string<? current-s min-s)
            (set! min-s current-s)))
        min-s)
      (list->string (sort (string->list s) char<=?))))