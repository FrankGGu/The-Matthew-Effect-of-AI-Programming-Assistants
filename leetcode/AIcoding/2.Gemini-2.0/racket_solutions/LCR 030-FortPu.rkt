(define (randomized-set)
  (struct randomized-set (values idxs) #:mutable))

(define (randomized-set-new)
  (randomized-set (hash)))

(define (randomized-set-insert! set val)
  (let ((values (randomized-set-values set)))
    (if (hash-has-key? values val)
        #f
        (begin
          (hash-set! values val (list))
          #t))))

(define (randomized-set-remove! set val)
  (let ((values (randomized-set-values set)))
    (if (hash-has-key? values val)
        (begin
          (hash-remove! values val)
          #t)
        #f)))

(define (randomized-set-get-random set)
  (let ((values (randomized-set-values set)))
    (if (hash-empty? values)
        #f
        (let ((keys (hash-keys values)))
          (list-ref keys (random (length keys)))))))

(define (main)
  (let ((set (randomized-set-new)))
    (printf "Insert 1: ~a\n" (randomized-set-insert! set 1))
    (printf "Remove 2: ~a\n" (randomized-set-remove! set 2))
    (printf "Insert 2: ~a\n" (randomized-set-insert! set 2))
    (printf "Get Random: ~a\n" (randomized-set-get-random set))
    (printf "Remove 1: ~a\n" (randomized-set-remove! set 1))
    (printf "Insert 2: ~a\n" (randomized-set-insert! set 2))
    (printf "Get Random: ~a\n" (randomized-set-get-random set))))