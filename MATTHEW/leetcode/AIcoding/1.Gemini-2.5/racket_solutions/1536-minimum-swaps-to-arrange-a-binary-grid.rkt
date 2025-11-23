#lang racket

(define (count-leading-zeros row n)
  (let loop ((j 0)
             (count 0))
    (if (= j n)
        count
        (if (= (list-ref row j) 0)
            (loop (+ j 1) (+ count 1))
            count))))

(define (min-swaps grid)
  (let* ((n (length grid))
         (leading-zeros (map (lambda (row) (count-leading-zeros row n)) grid)))

    (let loop ((i 0)
               (current-lzs leading-zeros)
               (swaps 0))
      (if (= i n)
          swaps
          (let* ((required-lz i))

            (let find-k ((k i))
              (cond
                ((= k n) -1)
                ((>= (list-ref current-lzs k) required-lz) k)
                (else (find-k (+ k 1)))))

            (let ((found-k (find-k i)))
              (if (= found-k -1)
                  -1
                  (let* ((num-swaps (- found-k i))
                         (lz-to-move (list-ref current-lzs found-k))
                         (new-lzs (append (take current-lzs i)
                                          (list lz-to-move)
                                          (take (drop current-lzs i) (- found-k i))
                                          (drop current-lzs (+ found-k 1)))))
                    (loop (+ i 1)
                          new-lzs
                          (+ swaps num-swaps))))))))))