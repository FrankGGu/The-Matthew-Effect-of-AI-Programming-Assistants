(define (garbage-collection garbage travel)
  (let* ((n (length garbage))
         (last-m 0)
         (last-p 0)
         (last-g 0)
         (total-m 0)
         (total-p 0)
         (total-g 0)
         (travel-m 0)
         (travel-p 0)
         (travel-g 0))
    (for/list ((i (in-range n)))
      (let ((g (list->string (string->list (list-ref garbage i)))))
        (cond
          [(string-contains? g "M")
           (set! last-m i)
           (set! total-m (+ total-m (string-length g)))]
          [else #f])
        (cond
          [(string-contains? g "P")
           (set! last-p i)
           (set! total-p (+ total-p (string-length g)))]
          [else #f])
        (cond
          [(string-contains? g "G")
           (set! last-g i)
           (set! total-g (+ total-g (string-length g)))]
          [else #f])))

    (for/list ((i (in-range (- n 1))))
      (let ((t (list-ref travel i)))
        (if (< i last-m)
            (set! travel-m (+ travel-m t))
            #f)
        (if (< i last-p)
            (set! travel-p (+ travel-p t))
            #f)
        (if (< i last-g)
            (set! travel-g (+ travel-g t))
            #f)))

    (+ total-m total-p total-g travel-m travel-p travel-g)))