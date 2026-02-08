(define (groups-of-strings strings)
  (define (bitmask s)
    (for/fold ([mask 0]) ([c (in-string s)])
      (bitwise-ior mask (arithmetic-shift 1 (- (char->integer c) (char->integer #\a))))))

  (define (find-set uf x)
    (if (equal? x (hash-ref uf x))
        x
        (let ([root (find-set uf (hash-ref uf x))])
          (hash-set! uf x root)
          root)))

  (define (union-sets uf x y)
    (let ([root-x (find-set uf x)]
          [root-y (find-set uf y)])
      (unless (equal? root-x root-y)
        (hash-set! uf root-x root-y))))

  (let* ([masks (map bitmask strings)]
         [uf (make-hash)]
         [count (length strings)])

    (for ([mask masks])
      (hash-set! uf mask mask))

    (for ([i (in-range count)])
      (for ([j (in-range i count)])
        (when (<= (bitwise-bit-count (bitwise-xor (list-ref masks i) (list-ref masks j))) 2)
          (union-sets uf (list-ref masks i) (list-ref masks j)))))

    (let ([roots (set)])
      (for ([mask masks])
        (set-add! roots (find-set uf mask))))

    (list (set-count roots) count)))