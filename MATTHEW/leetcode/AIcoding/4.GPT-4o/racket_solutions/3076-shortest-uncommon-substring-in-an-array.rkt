#lang racket

(define (shortestUncommonSubstring arr)
  (define (is-uncommon? substr)
    (not (ormap (lambda (s) (string-contains? s substr)) arr)))

  (define (find-substrings s)
    (for/fold ([subs '()]) ([i (in-range (string-length s))])
      (for ([j (in-range (+ i 1 (string-length s)))])
        (let ([substr (substring s i j)])
          (if (is-uncommon? substr)
              (cons substr subs)
              subs)))))

  (define unique-subs (for/fold ([subs '()]) ([s arr])
                          (append subs (find-substrings s))))

  (define shortest (apply min (map string-length unique-subs)))

  (define (get-shortest-substring)
    (for ([s unique-subs])
      (when (= (string-length s) shortest)
        (return s))))

  (get-shortest-substring))

(define (shortest-uncommon-substring arr)
  (shortestUncommonSubstring arr))