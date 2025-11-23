(define/contract (find-radius houses heaters)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([sorted-houses (sort houses <)]
         [sorted-heaters (sort heaters <)]
         [n (length sorted-heaters)]
         [radius 0]
         [i 0])
    (for ([house (in-list sorted-houses)])
      (let loop ()
        (cond
          [(< i (sub1 n))
           (if (< (abs (- house (list-ref sorted-heaters i)))
                 (abs (- house (list-ref sorted-heaters (add1 i)))))
               (set! radius (max radius (abs (- house (list-ref sorted-heaters i)))))
               (begin
                 (set! i (add1 i))
                 (loop)))]
          [else
           (set! radius (max radius (abs (- house (list-ref sorted-heaters i)))))])))
    radius))