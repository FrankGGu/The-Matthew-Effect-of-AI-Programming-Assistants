#lang racket

(define (find-longest-special-substring-that-occurs-thrice-ii s)
  (define n (string-length s))
  (when (< n 3)
    -1)

  (define char-runs (make-hash)) ; Map char -> (list of run lengths)

  (let loop ((i 0))
    (when (< i n)
      (define current-char (string-ref s i))
      (define count 0)
      (let inner-loop ((j i))
        (if (and (< j n) (char=? (string-ref s j) current-char))
            (begin
              (set! count (+ count 1))
              (inner-loop (+ j 1)))
            (begin
              (hash-set! char-runs current-char
                         (cons count (hash-ref char-runs current-char '())))
              (loop j))))))

  (define max-overall-L -1)

  (for ([(char lengths) char-runs])
    (define sorted-lengths (sort lengths >)) ; Sort descending

    (define l1 (if (not (empty? sorted-lengths)) (car sorted-lengths) 0))
    (define l2 (if (> (length sorted-lengths) 1) (list-ref sorted-lengths 1) 0))
    (define l3 (if (> (length sorted-lengths) 2) (list-ref sorted-lengths 2) 0))

    ;; Case 1: From a single run (l1)
    ;; We need l1 - L + 1 >= 3  => L <= l1 - 2
    ;; Max L is l1 - 2. Must be at least 1.
    (when (>= l1 3)
      (set! max-overall-L (max max-overall-L (- l1 2))))

    ;; Case 2: From two runs (l1, l2)
    ;; We need (l1 - L + 1) + (l2 - L + 1) >= 3
    ;; => l1 + l2 - 2L + 2 >= 3
    ;; => l1 + l2 - 1 >= 2L
    ;; => L <= (l1 + l2 - 1) / 2 (integer division)
    ;; Also L must be <= l2 (since l2 is the shorter of the two used runs for length L)
    ;; Max L is min(l2, (l1 + l2 - 1) / 2). Must be at least 1.
    (when (>= l2 1) ; Ensure l2 exists and is at least 1
      (define candidate-L (quotient (+ l1 l2 -1) 2))
      (set! max-overall-L (max max-overall-L (min l2 candidate-L))))

    ;; Case 3: From three runs (l1, l2, l3)
    ;; We need (l1 - L + 1) + (l2 - L + 1) + (l3 - L + 1) >= 3
    ;; => l1 + l2 + l3 - 3L + 3 >= 3
    ;; => l1 + l2 + l3 >= 3L
    ;; => L <= (l1 + l2 + l3) / 3 (integer division)
    ;; Also L must be <= l3 (since l3 is the shortest of the three used runs for length L)
    ;; Max L is min(l3, (l1 + l2 + l3) / 3). Must be at least 1.
    (when (>= l3 1) ; Ensure l3 exists and is at least 1
      (define candidate-L (quotient (+ l1 l2 l3) 3))
      (set! max-overall-L (max max-overall-L (min l3 candidate-L)))))

  (if (>= max-overall-L 1)
      max-overall-L
      -1))