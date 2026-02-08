(define (maximum-swap num)
  (let* ((digits (string->list (number->string num)))
         (len (length digits))
         (last-occ (make-hash)))
    (for ([i (in-range len)])
      (hash-set! last-occ (string->number (string (list-ref digits i))) i))
    (let loop ([i 0] [digits digits] [swapped? #f])
      (cond
        [(or swapped? (>= i len)) (string->number (list->string digits))]
        [else
         (let* ((current (string->number (string (list-ref digits i))))
                (d 9))
           (let find-max ([d 9])
             (cond
               [(< d current) (loop (add1 i) digits #f)]
               [(not (hash-has-key? last-occ d)) (find-max (sub1 d))]
               [(<= (hash-ref last-occ d) i) (find-max (sub1 d))]
               [else
                (let* ((j (hash-ref last-occ d))
                  (let ([new-digits (list-copy digits)])
                    (list-set! new-digits i (list-ref digits j))
                    (list-set! new-digits j (list-ref digits i))
                    (loop (add1 i) new-digits #t)))])))])))))