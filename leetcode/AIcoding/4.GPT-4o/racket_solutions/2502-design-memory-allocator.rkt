#lang racket

(define MemoryAllocator
  (struct MemoryAllocator (size blocks))

  (define (create size)
    (MemoryAllocator size (list (list 0 size))))

  (define (malloc this n)
    (define blocks (MemoryAllocator-blocks this))
    (define (find-fit blocks n)
      (for/fold ([result #f]) ([block blocks])
        (if (and (not result) (>= (second block) n))
            (list (first block) n)
            result)))
    (define fit (find-fit blocks n))
    (if fit
      (begin
        (define start (first fit))
        (define alloc-size (second fit))
        (set! blocks (filter (lambda (b) (not (= (first b) start))) blocks))
        (set! blocks (cons (list start (- alloc-size n)) blocks))
        (set! blocks (cons (list (+ start alloc-size) (- (second (first fit)) alloc-size)) blocks))
        (set! blocks (sort blocks (lambda (a b) (< (first a) (first b)))))
        (set! this (MemoryAllocator (MemoryAllocator-size this) blocks))
        start)
      -1)))

  (define (free this ptr)
    (define blocks (MemoryAllocator-blocks this))
    (set! blocks (append blocks (list (list ptr 0))))
    (set! this (MemoryAllocator (MemoryAllocator-size this) (sort blocks (lambda (a b) (< (first a) (first b)))))))

  (define (getBlocks this)
    (MemoryAllocator-blocks this))

  (define (main)
    (define allocator (create 10))
    (define p1 (malloc allocator 2))
    (define p2 (malloc allocator 3))
    (free allocator p1)
    (define p3 (malloc allocator 2))
    (list p1 p2 p3))
)

(define alloc (MemoryAllocator))
(alloc)