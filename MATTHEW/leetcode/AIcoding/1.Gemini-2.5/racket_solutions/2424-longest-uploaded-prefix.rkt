#lang racket

(define-struct (LUPrefix #:mutable) (uploaded longest-prefix))

(define (LUPrefix-init n)
  (LUPrefix (make-vector (+ n 1) #f) ; `uploaded` vector: index 0 is unused, 1 to n for videos
            0))                       ; `longest-prefix`: initially 0

(define (LUPrefix-upload luprefix video)
  ;; Mark the current video as uploaded
  (vector-set! (LUPrefix-uploaded luprefix) video #t)

  ;; Check if the longest prefix can be extended
  (let loop ()
    (let* ((current-longest (LUPrefix-longest-prefix luprefix))
           (next-video (+ current-longest 1))
           (uploaded-vec (LUPrefix-uploaded luprefix))
           (vec-len (vector-length uploaded-vec)))

      ;; If the next video in sequence is within bounds and is uploaded,
      ;; extend the longest prefix and continue checking
      (when (and (< next-video vec-len)
                 (vector-ref uploaded-vec next-video))
        (set-LUPrefix-longest-prefix! luprefix next-video)
        (loop))))) ; Tail recursion to continue extending the prefix

(define (LUPrefix-longest luprefix)
  (LUPrefix-longest-prefix luprefix))