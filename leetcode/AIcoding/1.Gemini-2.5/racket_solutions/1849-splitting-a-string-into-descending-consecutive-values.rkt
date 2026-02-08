(define (split-string s)
  (define n (string-length s))

  (define (dfs index prev-num)
    (if (= index n)
        #t
        (let loop ((i index))
          (if (= i n)
              #f
              (let* ((current-num-str (substring s index (+ i 1)))
                     (current-num (string->number current-num-str)))
                (if (and current-num (= current-num (- prev-num 1)))
                    (if (dfs (+ i 1) current-num)
                        #t
                        (loop (+ i 1)))
                    (loop (+ i 1))))))))

  (let loop-first-num ((i 0))
    (if (>= i (- n 1))
        #f
        (let* ((first-num-str (substring s 0 (+ i 1)))
               (first-num (string->number first-num-str)))
          (if (dfs (+ i 1) first-num)
              #t
              (loop-first-num (+ i 1)))))))