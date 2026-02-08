(define/contract (is-path-crossing path)
  (-> string? boolean?)
  (let loop ([x 0] [y 0] [visited (set (list 0 0))] [i 0])
    (if (>= i (string-length path))
        #f
        (let* ([dir (string-ref path i)]
               [new-x (if (char=? dir #\N) x (if (char=? dir #\S) x (+ x (if (char=? dir #\E) 1 -1)))]
               [new-y (if (char=? dir #\N) (+ y 1) (if (char=? dir #\S) (- y 1) y))]
               [pos (list new-x new-y)])
          (if (set-member? visited pos)
              #t
              (loop new-x new-y (set-add visited pos) (+ i 1)))))))