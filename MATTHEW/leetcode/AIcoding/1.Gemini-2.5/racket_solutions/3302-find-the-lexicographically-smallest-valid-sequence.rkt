#lang racket

(define (find-lexicographically-smallest-valid-sequence n)
  (define seq-len (- (* 2 n) 1))
  (define sequence (make-vector seq-len 0))
  (define used (make-vector (+ n 1) #f))
  (define count-1-used #f)

  (define (solve index return-solution)
    (cond
      [(= index seq-len)
       (return-solution (vector->list sequence))]

      [(not (= (vector-ref sequence index) 0))
       (solve (+ index 1) return-solution)]

      [else
       (for ([num (in-range 1 (+ n 1))])
         (cond
           [(= num 1)
            (when (not count-1-used)
              (vector-set! sequence index 1)
              (set! count-1-used #t)
              (solve (+ index 1) return-solution)
              (set! count-1-used #f)
              (vector-set! sequence index 0))]

           [else
            (when (not (vector-ref used num))
              (let ([second-pos (+ index num)])
                (when (and (< second-pos seq-len)
                           (= (vector-ref sequence second-pos) 0))
                  (vector-set! sequence index num)
                  (vector-set! sequence second-pos num)
                  (vector-set! used num #t)
                  (solve (+ index 1) return-solution)
                  (vector-set! used num #f)
                  (vector-set! sequence second-pos 0)
                  (vector-set! sequence index 0)))))]))
       #f]))

  (call-with-current-continuation
   (lambda (return-solution)
     (solve 0 return-solution)
     #f)))