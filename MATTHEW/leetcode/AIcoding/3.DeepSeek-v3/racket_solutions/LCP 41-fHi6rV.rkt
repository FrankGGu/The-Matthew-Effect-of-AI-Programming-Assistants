(define (flipChess board)
  (define rows (length board))
  (define cols (if (null? board) 0 (string-length (car board))))
  (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))

  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (char-at r c)
    (string-ref (list-ref board r) c))

  (define (flip r c dr dc)
    (let loop ((r (+ r dr)) (c (+ c dc)) (path '()))
      (cond
        [(not (valid? r c)) '()]
        [(char=? (char-at r c) #\.) '()]
        [(char=? (char-at r c) #\X) path]
        [else (loop (+ r dr) (+ c dc) (cons (cons r c) path))])))

  (define (try-flip r c)
    (for/fold ([total 0]) ([dir directions])
      (match-define (list dr dc) dir)
      (let ([path (flip r c dr dc)])
        (for ([p path])
          (match-define (cons pr pc) p)
          (set! board (list-set board pr (string-set (list-ref board pr) pc #\X))))
        (+ total (length path))))

  (define (solve)
    (let loop ([max-flips 0])
      (let ([current-max 0]
            [best-move #f])
        (for* ([r rows] [c cols] #:when (char=? (char-at r c) #\.))
          (let ([flips (try-flip r c)])
            (when (> flips 0)
              (when (> flips current-max)
                (set! current-max flips)
                (set! best-move (cons r c)))
              (for ([p (flip r c (car dir) (cadr dir))])
                (match-define (cons pr pc) p)
                (set! board (list-set board pr (string-set (list-ref board pr) pc #\O))))))
        (if (zero? current-max)
            max-flips
            (begin
              (match-define (cons br bc) best-move)
              (set! board (list-set board br (string-set (list-ref board br) bc #\X)))
              (for ([dir directions])
                (let ([path (flip br bc (car dir) (cadr dir))])
                  (for ([p path])
                    (match-define (cons pr pc) p)
                    (set! board (list-set board pr (string-set (list-ref board pr) pc #\X)))))
              (loop (+ max-flips current-max 1)))))))

  (solve))