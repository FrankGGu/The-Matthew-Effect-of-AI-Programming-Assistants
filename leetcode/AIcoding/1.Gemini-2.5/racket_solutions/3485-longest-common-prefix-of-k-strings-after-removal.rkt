#lang racket

(define (longest-common-prefix strs)
  (cond
    [(null? strs) ""]
    [(null? (rest strs)) (first strs)]
    [else
     (let loop ((current-lcp (first strs))
                (remaining (rest strs)))
       (if (null? remaining)
           current-lcp
           (let* ((next-str (first remaining))
                  (lcp-len (let inner-loop ((i 0))
                             (if (or (>= i (string-length current-lcp))
                                     (>= i (string-length next-str))
                                     (not (char=? (string-ref current-lcp i) (string-ref next-str i))))
                                 i
                                 (inner-loop (+ i 1))))))
             (loop (substring current-lcp 0 lcp-len) (rest remaining)))))]))