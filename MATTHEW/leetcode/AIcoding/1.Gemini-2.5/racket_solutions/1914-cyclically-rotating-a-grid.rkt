#lang racket

(define (rotate-grid grid k)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0))) ; Assumes non-empty grid

  ; Create a deep copy of the grid to modify
  (define new-grid (make-vector m))
  (for ([i (in-range m)])
    (vector-set! new-grid i (make-vector n)))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (vector-set! (vector-ref new-grid r) c (vector-ref (vector-ref grid r) c))))

  (define (get-cell r c)
    (vector-ref (vector-ref new-grid r) c))

  (define (set-cell! r c val)
    (vector-set! (vector-ref new-grid r) c val))

  (define (extract-layer r_s c_s r_e c_e)
    (define elements '())
    (cond
      ; Single element layer
      [(and (= r_s r_e) (= c_s c_e))
       (list (get-cell r_s c_s))]
      ; Single row layer
      [(= r_s r_e)
       (for ([c (in-range c_s (+ c_e 1))])
         (set! elements (cons (get-cell r_s c) elements)))
       (reverse elements)]
      ; Single column layer
      [(= c_s c_e)
       (for ([r (in-range r_s (+ r_e 1))])
         (set! elements (cons (get-cell r c_s) elements)))
       (reverse elements)]
      ; General rectangular layer
      [else
       ; Top row (left to right)
       (for ([c (in-range c_s (+ c_e 1))])
         (set! elements (cons (get-cell r_s c) elements)))
       ; Right column (top to bottom, excluding top-right)
       (for ([r (in-range (+ r_s 1) (+ r_e 1))])
         (set! elements (cons (get-cell r c_e) elements)))
       ; Bottom row (right to left, excluding bottom-right)
       (for ([c (in-range (- c_e 1) (- c_s 1) -1)])
         (set! elements (cons (get-cell r_e c) elements)))
       ; Left column (bottom to top, excluding bottom-left and top-left)
       (for ([r (in-range (- r_e 1) r_s -1)])
         (set! elements (cons (get-cell r c_s) elements)))
       (reverse elements)]))

  (define (rotate-list lst k-val)
    (if (empty? lst)
        '()
        (let* ([len (length lst)]
               [actual-k (modulo k-val len)])
          (append (list-tail lst actual-k) (list-head lst actual-k)))))

  (define (place-layer r_s c_s r_e c_e rotated-elements)
    (define current-idx 0)
    (define (get-next-element)
      (let ([val (list-ref rotated-elements current-idx)])
        (set! current-idx (+ current-idx 1))
        val))

    (cond
      ; Single element layer
      [(and (= r_s r_e) (= c_s c_e))
       (set-cell! r_s c_s (get-next-element))]
      ; Single row layer
      [(= r_s r_e)
       (for ([c (in-range c_s (+ c_e 1))])
         (set-cell! r_s c (get-next-element)))]
      ; Single column layer
      [(= c_s c_e)
       (for ([r (in-range r_s (+ r_e 1))])
         (set-cell! r c_s (get-next-element)))]
      ; General rectangular layer
      [else
       ; Top row (left to right)
       (for ([c (in-range c_s (+ c_e 1))])
         (set-cell! r_s c (get-next-element)))
       ; Right column (top to bottom, excluding top-right)
       (for ([r (in-range (+ r_s 1) (+ r_e 1))])
         (set-cell! r c_e (get-next-element)))
       ; Bottom row (right to left, excluding bottom-right)
       (for ([c (in-range (- c_e 1) (- c_s 1) -1)])
         (set-cell! r_e c (get-next-element)))
       ; Left column (bottom to top, excluding bottom-left and top-left)
       (for ([r (in-range (- r_e 1) r_s -1)])
         (set-cell! r c_s (get-next-element)))]))

  (define i 0)
  (let loop ()
    (define r_start i)
    (define c_start i)
    (define r_end (- m 1 i))
    (define c_end (- n 1 i))

    (when (and (<= r_start r_end) (<= c_start c_end))
      (define current-layer-elements (extract-layer r_start c_start r_end c_end))
      (define rotated-layer-elements (rotate-list current-layer-elements k))
      (place-layer r_start c_start r_end c_end rotated-layer-elements)
      (set! i (+ i 1))
      (loop)))

  new-grid)