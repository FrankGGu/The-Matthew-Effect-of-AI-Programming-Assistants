#lang racket

(define (can-place-at-pos? grid r c dr dc word)
  (define R (vector-length grid))
  (define C (string-length (vector-ref grid 0)))
  (define L (string-length word))

  ;; Check preceding character
  (define preceding-ok?
    (let ((prev-r (- r dr))
          (prev-c (- c dc)))
      (if (and (>= prev-r 0) (< prev-r R)
               (>= prev-c 0) (< prev-c C))
          (char=? (string-ref (vector-ref grid prev-r) prev-c) #\#)
          #t))) ; If no preceding cell (boundary), it's ok

  ;; Check succeeding character
  (define succeeding-ok?
    (let ((next-r (+ r (* dr L)))
          (next-c (+ c (* dc L))))
      (if (and (>= next-r 0) (< next-r R)
               (>= next-c 0) (< next-c C))
          (char=? (string-ref (vector-ref grid next-r) next-c) #\#)
          #t))) ; If no succeeding cell (boundary), it's ok

  ;; Check characters within the segment
  (define segment-chars-ok?
    (for/all ([k (in-range L)])
      (define curr-r (+ r (* dr k)))
      (define curr-c (+ c (* dc k)))
      (define grid-char (string-ref (vector-ref grid curr-r) curr-c))
      (define word-char (string-ref word k))
      (or (char=? grid-char #\ )
          (char=? grid-char word-char))))

  (and preceding-ok? succeeding-ok? segment-chars-ok?))

(define (place-word-in-crossword grid word)
  (define R (vector-length grid))
  (define C (string-length (vector-ref grid 0)))
  (define L (string-length word))

  (define reversed-word (string-reverse word))

  (or
   ;; Check horizontal placements
   (for/or ([r (in-range R)])
     (for/or ([c (in-range (+ 1 (- C L)))]) ; c from 0 to C-L (inclusive)
       (or (can-place-at-pos? grid r c 0 1 word)
           (can-place-at-pos? grid r c 0 1 reversed-word))))

   ;; Check vertical placements
   (for/or ([c (in-range C)])
     (for/or ([r (in-range (+ 1 (- R L)))]) ; r from 0 to R-L (inclusive)
       (or (can-place-at-pos? grid r c 1 0 word)
           (can-place-at-pos? grid r c 1 0 reversed-word))))))