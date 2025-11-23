(define/contract (maximum-white-tiles tiles carpetLen)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define sorted-tiles (sort tiles (lambda (a b) (< (car a) (car b)))))
  (define n (length sorted-tiles))
  (define max-covered 0)
  (define prefix (make-vector (add1 n) 0))

  (for ([i (in-range 1 (add1 n))])
    (define prev (vector-ref prefix (sub1 i)))
    (define current (list-ref sorted-tiles (sub1 i)))
    (vector-set! prefix i (+ prev (- (cadr current) (car current) -1))))

  (let loop ([left 0] [right 0])
    (cond
      [(or (>= left n) (>= right n)) max-covered]
      [else
       (define start (car (list-ref sorted-tiles left)))
       (define end (+ start carpetLen -1))
       (cond
         [(> (car (list-ref sorted-tiles right))) end)
          (loop left (add1 right))]
         [else
          (define covered
            (+ (- (vector-ref prefix right) (vector-ref prefix left))
               (max 0 (- end (car (list-ref sorted-tiles right))) -1))))
          (set! max-covered (max max-covered covered))
          (loop (add1 left) right)])])))