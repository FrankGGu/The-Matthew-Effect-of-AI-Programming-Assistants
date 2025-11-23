#lang racket
(require racket/vector)

(define (sliding-subarray-beauty nums k x)
  (let* ((n (length nums)))

    (define (get-xth-smallest freq x)
      (let loop ((idx 0) (count 0))
        (let ((current-freq (vector-ref freq idx)))
          (cond
            ((>= (+ count current-freq) x)
             (- idx 50))
            (else
             (loop (+ idx 1) (+ count current-freq)))))))

    (define (calculate-beauty-val val)
      (if (< val 0) val 0))

    (define freq (make-vector 101 0))
    (for ((i (in-range k)))
      (let ((val (list-ref nums i)))
        (vector-set! freq (+ val 50) (add1 (vector-ref freq (+ val 50))))))

    (define first-beauty (calculate-beauty-val (get-xth-smallest freq x)))

    (let loop ((i 1) (current-freq freq) (acc (list first-beauty)))
      (if (>= i (- n k -1))
          (reverse acc)
          (let* ((left-idx (- i 1))
                 (right-idx (+ i k -1))
                 (left-val (list-ref nums left-idx))
                 (right-val (list-ref nums right-idx))
                 (new-freq (vector-copy current-freq)))

            (vector-set! new-freq (+ left-val 50)
                         (sub1 (vector-ref new-freq (+ left-val 50))))

            (vector-set! new-freq (+ right-val 50)
                         (add1 (vector-ref new-freq (+ right-val 50))))

            (let ((new-beauty (calculate-beauty-val (get-xth-smallest new-freq x))))
              (loop (add1 i) new-freq (cons new-beauty acc))))))))