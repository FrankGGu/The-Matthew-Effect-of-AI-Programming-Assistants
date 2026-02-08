#lang racket

(define (add-one-to-binary-vector bin-vec)
  (let* ((len (vector-length bin-vec))
         (new-vec (vector-copy bin-vec)))
    (let loop ((idx (- len 1))
               (carry 1))
      (if (< idx 0)
          (if (= carry 1)
              (vector-append (vector #\1) new-vec)
              new-vec)
          (let ((digit (vector-ref new-vec idx)))
            (if (= carry 1)
                (if (char=? digit #\0)
                    (begin
                      (vector-set! new-vec idx #\1)
                      new-vec)
                    (begin
                      (vector-set! new-vec idx #\0)
                      (loop (- idx 1) 1)))
                new-vec))))))

(define (num-steps s)
  (let loop ((current-bin-vec (list->vector (string->list s)))
             (steps 0))
    (if (and (= (vector-length current-bin-vec) 1) (char=? (vector-ref current-bin-vec 0) #\1))
        steps
        (let* ((len (vector-length current-bin-vec))
               (last-digit (vector-ref current-bin-vec (- len 1))))
          (if (char=? last-digit #\0)
              (loop (subvector current-bin-vec 0 (- len 1)) (+ steps 1))
              (loop (add-one-to-binary-vector current-bin-vec) (+ steps 1)))))))