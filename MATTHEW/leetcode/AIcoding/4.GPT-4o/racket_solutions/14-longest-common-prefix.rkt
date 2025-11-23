(define (longestCommonPrefix strs)
  (if (null? strs)
      ""
      (let loop ((prefix (car strs)) (rest (cdr strs)))
        (if (or (null? rest) (string? prefix) (string? (car rest)))
            prefix
            (let ((new-prefix (longest-prefix prefix (car rest))))
              (loop new-prefix (cdr rest)))))))

(define (longest-prefix s1 s2)
  (let loop ((i 0))
    (if (or (>= i (string-length s1)) (>= i (string-length s2)))
        (substring s1 0 i)
        (if (char=? (string-ref s1 i) (string-ref s2 i))
            (loop (+ i 1))
            (substring s1 0 i)))))

(longestCommonPrefix '("flower" "flow" "flight"))