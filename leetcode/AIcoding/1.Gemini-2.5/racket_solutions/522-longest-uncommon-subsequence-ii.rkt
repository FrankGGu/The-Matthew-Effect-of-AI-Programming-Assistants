#lang racket

(define (is-subsequence? s1 s2)
  (let* ([len1 (string-length s1)]
         [len2 (string-length s2)])
    (if (> len1 len2)
        #f
        (let loop ([p1 0] [p2 0])
          (cond
            [(= p1 len1) #t]
            [(= p2 len2) #f]
            [(char=? (string-ref s1 p1) (string-ref s2 p2))
             (loop (+ p1 1) (+ p2 1))]
            [else
             (loop p1 (+ p2 1))])))))

(define (find-lus-length strs)
  (let* ([n (length strs)]
         [sorted-strs (sort strs (lambda (s1 s2) (> (string-length s1) (string-length s2))))])

    (define (is-uncommon-candidate? candidate-str candidate-idx)
      (for/and ([j (in-range n)]
                [s-j (in-list sorted-strs)])
        (or (= j candidate-idx)
            (not (is-subsequence? candidate-str s-j)))))

    (let ([result (for/first ([i (in-range n)]
                               [s-i (in-list sorted-strs)]
                               #:when (is-uncommon-candidate? s-i i))
                    (string-length s-i))])
      (if (void? result)
          -1
          result))))