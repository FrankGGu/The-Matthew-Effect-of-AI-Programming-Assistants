#lang racket

(define (get-smallest-string n k)
  (let loop ((current-n n)
             (current-k k)
             (result-chars '()))
    (if (zero? current-n)
        (list->string (reverse result-chars))
        (let* ((l-rem (- current-n 1)) ; remaining length
               (min-k-for-rem l-rem)
               (max-k-for-rem (* 3 l-rem))
               (char-a-cost 1)
               (char-b-cost 2)
               (char-c-cost 3))

          ;; Try 'a'
          (let ((k-rem-a (- current-k char-a-cost)))
            (if (and (<= min-k-for-rem k-rem-a) (<= k-rem-a max-k-for-rem))
                (loop l-rem k-rem-a (cons #\a result-chars))
                ;; Try 'b'
                (let ((k-rem-b (- current-k char-b-cost)))
                  (if (and (<= min-k-for-rem k-rem-b) (<= k-rem-b max-k-for-rem))
                      (loop l-rem k-rem-b (cons #\b result-chars))
                      ;; Must be 'c'
                      (let ((k-rem-c (- current-k char-c-cost)))
                        (loop l-rem k-rem-c (cons #\c result-chars)))))))))))