(define (open-lock deadends target)
  (define dead (make-hash))
  (for ([d deadends])
    (hash-set! dead d #t))
  (if (hash-has-key? dead "0000")
      -1
      (let loop ([queue (list "0000")]
                 [visited (make-hash)]
                 [steps 0])
        (if (null? queue)
            -1
            (let ([new-queue '()])
              (for ([current queue])
                (if (equal? current target)
                    steps
                    (for ([i (in-range 4)])
                      (let* ([c (string-ref current i)]
                             [up (modulo (+ (char->integer c) (- (char->integer #\0)) 1) 10)]
                             [down (modulo (+ (char->integer c) (- (char->integer #\0)) 9) 10)]
                             [next-up (string-copy current)]
                             [next-down (string-copy current)])
                        (string-set! next-up i (integer->char (+ up (char->integer #\0))))
                        (string-set! next-down i (integer->char (+ down (char->integer #\0))))
                        (unless (or (hash-has-key? dead next-up) (hash-has-key? visited next-up))
                          (hash-set! visited next-up #t)
                          (set! new-queue (cons next-up new-queue)))
                        (unless (or (hash-has-key? dead next-down) (hash-has-key? visited next-down))
                          (hash-set! visited next-down #t)
                          (set! new-queue (cons next-down new-queue))))))
              (if (null? new-queue)
                  -1
                  (loop new-queue visited (add1 steps)))))))