(define (executeInstructions n instructions startPos)
  (define (move pos dir)
    (match dir
      [(list 0 1) (if (< (second pos) (- n 1)) (list (first pos) (+ (second pos) 1)) (list -1 -1))]
      [(list 0 -1) (if (> (second pos) 0) (list (first pos) (- (second pos) 1)) (list -1 -1))]
      [(list 1 0) (if (< (first pos) (- n 1)) (list (+ (first pos) 1) (second pos)) (list -1 -1))]
      [(-1 0) (if (> (first pos) 0) (list (- (first pos) 1) (second pos)) (list -1 -1))]))

  (define (execute from)
    (define pos startPos)
    (define count 0)
    (for/list ([i (in-range from (length instructions))])
      (let ([dir (list (char->integer (string-ref instructions i)) (char->integer (string-ref instructions i)))])
        (define new-pos (move pos dir))
        (if (and (not (= (first new-pos) -1)) (not (= (second new-pos) -1)))
            (begin
              (set! pos new-pos)
              (set! count (+ count 1)))
            (begin
              (set! count 0)
              (set! pos startPos)))
        count)))

  (for/list ([i (in-range (length instructions))])
    (execute i)))

(define (executeInstructionsWrapper n instructions startPos)
  (executeInstructions n (string->list instructions) startPos))

(executeInstructionsWrapper n instructions startPos)