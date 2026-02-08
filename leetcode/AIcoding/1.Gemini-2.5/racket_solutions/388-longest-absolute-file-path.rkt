#lang racket

(define (longest-absolute-path input)
  (define max-len 0)
  (define path-lengths (make-vector 101 0))
  (define current-depth-max -1)

  (define (get-depth-and-name s)
    (let loop ((i 0) (depth 0))
      (if (< i (string-length s))
          (if (char=? (string-ref s i) #\t)
              (loop (+ i 1) (+ depth 1))
              (values depth (substring s i)))
          (values depth ""))))

  (for-each (lambda (entry)
              (unless (string=? entry "")
                (define-values (depth name) (get-depth-and-name entry))

                (set! current-depth-max depth)

                (vector-set! path-lengths depth (string-length name))

                (when (string-contains? name ".")
                  (define current-path-total-len 0)
                  (for ((i (in-range (+ current-depth-max 1))))
                    (set! current-path-total-len (+ current-path-total-len (vector-ref path-lengths i))))

                  (define num-slashes (if (> (+ current-depth-max 1) 0) (- (+ current-depth-max 1) 1) 0))

                  (define total-abs-path-len (+ current-path-total-len num-slashes))
                  (when (> total-abs-path-len max-len)
                    (set! max-len total-abs-path-len)))))
            (string-split input "\n"))
  max-len)