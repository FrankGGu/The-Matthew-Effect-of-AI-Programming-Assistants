(define/contract (minimal-steps maze)
  (-> (listof string?) exact-integer?)
  (define rows (length maze))
  (define cols (string-length (first maze)))
  (define (char-at r c) (string-ref (list-ref maze r) c))

  (define start #f)
  (define target #f)
  (define stones '())
  (define triggers '())

  (for* ([r (in-range rows)] [c (in-range cols)])
    (case (char-at r c)
      [(#\S) (set! start (cons r c))]
      [(#\T) (set! target (cons r c))]
      [(#\O) (set! stones (cons (cons r c) stones))]
      [(#\M) (set! triggers (cons (cons r c) triggers))]))

  (define (bfs start end)
    (define visited (make-hash))
    (define q (make-queue))
    (enqueue! q (list start 0))
    (hash-set! visited start #t)

    (let loop ()
      (if (queue-empty? q)
          -1
          (let-values ([(pos dist) (dequeue! q)])
            (if (equal? pos end)
                dist
                (begin
                  (for ([dir '((0 . 1) (1 . 0) (0 . -1) (-1 . 0))])
                    (let ((nr (+ (car pos) (car dir)))
                         (nc (+ (cdr pos) (cdr dir))))
                      (when (and (>= nr 0) (< nr rows)
                                (>= nc 0) (< nc cols)
                                (not (char=? (char-at nr nc) #\#))
                                (not (hash-ref visited (cons nr nc) #f)))
                        (hash-set! visited (cons nr nc) #t)
                        (enqueue! q (list (cons nr nc) (+ dist 1))))))
                  (loop))))))

  (define m (length triggers))
  (define n (length stones))

  (when (or (not start) (not target) (zero? m) (not (= n m)))
    (return -1))

  (define dist-start (make-hash))
  (define dist-target (make-hash))

  (for ([stone stones])
    (hash-set! dist-start stone (bfs start stone))
    (hash-set! dist-target stone (bfs stone target)))

  (define dist-stones (make-hash))
  (for* ([s1 stones] [s2 stones])
    (unless (equal? s1 s2)
      (hash-set! dist-stones (cons s1 s2) (bfs s1 s2))))

  (define dist-triggers (make-hash))
  (for* ([t triggers] [s stones])
    (hash-set! dist-triggers (cons t s) (bfs t s)))

  (define dp (make-hash))

  (define (dfs mask last)
    (define key (cons mask last))
    (if (hash-has-key? dp key)
        (hash-ref dp key)
        (if (= mask (sub1 (expt 2 m)))
            (hash-ref dist-target last)
            (let ((res +inf.0))
              (for ([i (in-range m)])
                (unless (bitwise-bit-set? mask i)
                  (let ((trigger (list-ref triggers i)))
                    (for ([s stones])
                      (let ((d1 (hash-ref dist-stones (cons last s) +inf.0))
                           (d2 (hash-ref dist-triggers (cons trigger s) +inf.0)))
                        (when (and (< d1 +inf.0) (< d2 +inf.0))
                          (set! res (min res (+ d1 d2 (dfs (bitwise-ior mask (arithmetic-shift 1 i)) s))))))))))
              (hash-set! dp key res)
              res))))

  (define result (dfs 0 start))
  (if (= result +inf.0) -1 result))