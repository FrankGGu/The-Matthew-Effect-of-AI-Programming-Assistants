(define (shortest-path-all-keys grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define (get-start-pos)
    (for*/first ([i (in-range m)]
                  [j (in-range n)]
                  [(= (vector-ref (vector-ref grid i) j) #\@)])
      (list i j)))

  (define (is-valid? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define (bfs)
    (define start-pos (get-start-pos))
    (define start-r (car start-pos))
    (define start-c (cadr start-pos))
    (define all-keys (string->number-list "abcdef"))
    (define num-keys (length all-keys))
    (define target-keys (expt 2 num-keys))

    (define visited (make-hash))
    (hash-set! visited (list start-r start-c 0) #t)

    (define q (make-queue))
    (enqueue! q (list start-r start-c 0 0)) ; r, c, keys, steps

    (define directions (list (list 0 1) (list 0 -1) (list 1 0) (list -1 0)))

    (let loop ()
      (if (queue-empty? q)
          -1
          (let ([curr (dequeue! q)])
            (let ([r (car curr)]
                  [c (cadr curr)]
                  [keys (caddr curr)]
                  [steps (cadddr curr)])
              (cond
                [(= keys (- target-keys 1)) steps]
                [else
                 (for ([dir directions])
                   (let ([nr (+ r (car dir))]
                         [nc (+ c (cadr dir))])
                     (if (is-valid? nr nc)
                         (let ([cell (vector-ref (vector-ref grid nr) nc)])
                           (cond
                             [(char=? cell #\#) #f]
                             [(and (char=? cell #\A) (= (bitwise-and keys 1) 0)) #f]
                             [(and (char=? cell #\B) (= (bitwise-and keys 2) 0)) #f]
                             [(and (char=? cell #\C) (= (bitwise-and keys 4) 0)) #f]
                             [(and (char=? cell #\D) (= (bitwise-and keys 8) 0)) #f]
                             [(and (char=? cell #\E) (= (bitwise-and keys 16) 0)) #f]
                             [(and (char=? cell #\F) (= (bitwise-and keys 32) 0)) #f]
                             [else
                              (let ([new-keys (cond
                                                [(char=? cell #\a) (bitwise-ior keys 1)]
                                                [(char=? cell #\b) (bitwise-ior keys 2)]
                                                [(char=? cell #\c) (bitwise-ior keys 4)]
                                                [(char=? cell #\d) (bitwise-ior keys 8)]
                                                [(char=? cell #\e) (bitwise-ior keys 16)]
                                                [(char=? cell #\f) (bitwise-ior keys 32)]
                                                [else keys])])
                                (if (not (hash-has-key? visited (list nr nc new-keys)))
                                    (begin
                                      (hash-set! visited (list nr nc new-keys) #t)
                                      (enqueue! q (list nr nc new-keys (+ steps 1))))))]))))))))
                 (loop)]))))))

  (bfs))