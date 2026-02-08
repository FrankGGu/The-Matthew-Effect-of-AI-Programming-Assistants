#lang racket

(define (vector-swap! vec i j)
  (let ((temp (vector-ref vec i)))
    (vector-set! vec i (vector-ref vec j))
    (vector-set! vec j temp)))

(define (vector-reverse-sub! vec start end)
  (let loop ((l start) (r end))
    (when (< l r)
      (vector-swap! vec l r)
      (loop (+ l 1) (- r 1)))))

(define (next-permutation digits)
  (let* ((n (length digits))
         (vec (list->vector digits)))

    ;; Find the largest index i such that vec[i] < vec[i+1]
    (let loop-i ((i (- n 2)))
      (cond
        ((< i 0) #f) ; No such i, this is the last permutation
        ((char<? (vector-ref vec i) (vector-ref vec (+ i 1)))
         ;; Found i
         ;; Find the largest index j greater than i such that vec[j] > vec[i]
         (let loop-j ((j (- n 1)))
           (cond
             ((char>? (vector-ref vec j) (vector-ref vec i))
              ;; Found j, swap vec[i] and vec[j]
              (vector-swap! vec i j)
              ;; Reverse the sub-array from i+1 to n-1
              (vector-reverse-sub! vec (+ i 1) (- n 1))
              (vector->list vec))
             (else (loop-j (- j 1))))))
        (else (loop-i (- i 1)))))))

(define (min-adjacent-swaps original-digits target-digits)
  (let* ((n (length original-digits))
         (current-original (list->vector original-digits)) ; Mutable copy
         (swaps 0))
    (for ((i (in-range n)))
      (let ((target-char (list-ref target-digits i)))
        ;; Find the index j in current-original (from i onwards)
        ;; where current-original[j] matches target-char
        (let loop-find ((j i))
          (when (< j n)
            (cond
              ((char=? (vector-ref current-original j) target-char)
               ;; Found target-char at index j
               (set! swaps (+ swaps (- j i)))
               ;; Shift elements from j-1 down to i, moving current-original[j] to i
               (let ((char-to-move (vector-ref current-original j)))
                 (for ((k (in-range j i -1))) ; Iterate from j-1 down to i+1
                   (vector-set! current-original k (vector-ref current-original (- k 1))))
                 (vector-set! current-original i char-to-move)))
              (else (loop-find (+ j 1))))))))
    swaps))

(define (get-min-swaps num k)
  (let* ((original-digits (string->list num))
         (target-digits original-digits)) ; Start with original

    ;; Find the Kth smallest number (Kth next permutation)
    (for ((_ (in-range k)))
      (set! target-digits (next-permutation target-digits)))

    ;; Calculate minimum adjacent swaps
    (min-adjacent-swaps original-digits target-digits)))