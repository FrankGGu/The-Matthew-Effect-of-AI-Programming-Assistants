#lang racket
(require data/heap)
(require racket/hash)
(require racket/mutable-list)

(struct heap-wrapper (heap effective-size deleted-counts comparator) #:transparent)

(define (make-heap-wrapper comparator)
  (heap-wrapper (make-heap comparator) 0 (make-hash) comparator))

(define (clean-heap-top! hw)
  (let loop ()
    (let ([h (heap-wrapper-heap hw)]
          [deleted-counts (heap-wrapper-deleted-counts hw)])
      (when (and (not (heap-empty? h))
                 (> (hash-ref deleted-counts (heap-peek h) 0) 0))
        (let ([val (heap-pop! h)])
          (hash-update! deleted-counts val (lambda (v) (- v 1)) 0)
          (loop))))))

(define (hw-add! hw val)
  (heap-add! (heap-wrapper-heap hw) val)
  (set-heap-wrapper-effective-size! hw (+ (heap-wrapper-effective-size hw) 1)))

(define (hw-peek hw)
  (clean-heap-top! hw)
  (heap-peek (heap-wrapper-heap hw)))

(define (hw-pop! hw)
  (clean-heap-top! hw)
  (set-heap-wrapper-effective-size! hw (- (heap-wrapper-effective-size hw) 1))
  (heap-pop! (heap-wrapper-heap hw)))

(define (hw-size hw)
  (heap-wrapper-effective-size hw))

(define (hw-empty? hw)
  (= (hw-size hw) 0))

(define (hw-mark-deleted! hw val)
  (hash-update! (heap-wrapper-deleted-counts hw) val (lambda (v) (+ v 1)) 0)
  (set-heap-wrapper-effective-size! hw (- (heap-wrapper-effective-size hw) 1)))

(define (median-sliding-window nums k)
  (define results (make-mutable-list))

  (define max-h (make-heap-wrapper (lambda (a b) (> a b)))) 
  (define min-h (make-heap-wrapper <)) 

  (define (balance!)
    (when (and (not (hw-empty? max-h))
               (not (hw-empty? min-h))
               (> (hw-peek max-h) (hw-peek min-h)))
      (let ([max-val (hw-pop! max-h)]
            [min-val (hw-pop! min-h)])
        (hw-add! max-h min-val)
        (hw-add! min-h max-val)))

    (when (> (hw-size max-h) (+ (hw-size min-h) 1))
      (hw-add! min-h (hw-pop! max-h)))

    (when (> (hw-size min-h) (hw-size max-h))
      (hw-add! max-h (hw-pop! min-h))))

  (define (add-num! num)
    (if (or (hw-empty? max-h) (<= num (hw-peek max-h)))
        (hw-add! max-h num)
        (hw-add! min-h num))
    (balance!))

  (define (remove-num! num)
    (if (or (hw-empty? max-h) (<= num (hw-peek max-h)))
        (hw-mark-deleted! max-h num)
        (hw-mark-deleted! min-h num))
    (balance!))

  (define (get-median)
    (if (= (hw-size max-h) (hw-size min-h))
        (/ (+ (hw-peek max-h) (hw-peek min-h)) 2.0)
        (real (hw-peek max-h))))

  (for ([i (in-range (vector-length nums))])
    (let ([num (vector-ref nums i)])
      (add-num! num)

      (when (>= (+ i 1) k)
        (mutable-list-add! results (get-median))

        (let ([old-num (vector-ref nums (- i k))])
          (remove-num! old-num)))))

  (mutable-list->list results))