(define (strStr haystack needle)
  (cond
    [(= (string-length needle) 0) 0]
    [(> (string-length haystack) (string-length needle))
     (let loop ((i 0))
       (cond
         [(>= i (- (string-length haystack) (string-length needle))) -1]
         [(string=? (substring haystack i (+ i (string-length needle))) needle) i]
         [else (loop (+ i 1))]))]
    [else -1]))

(strStr "hello" "ll") ; should return 2
(strStr "aaaaa" "bba") ; should return -1
(strStr "" "") ; should return 0