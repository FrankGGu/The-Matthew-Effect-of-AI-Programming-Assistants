#lang racket

(define (is-one-edit-distance s1 s2)
  (let* ([len1 (string-length s1)]
         [len2 (string-length s2)]
         [diff (abs (- len1 len2))])

    (cond
      ;; If length difference is more than 1, cannot be one edit distance
      [(> diff 1) #f]
      ;; If lengths are equal, check for one substitution
      [(= len1 len2)
       (let loop ([i 0] [mismatches 0])
         (cond
           [(= i len1) (= mismatches 1)]
           [(char=? (string-ref s1 i) (string-ref s2 i)) (loop (+ i 1) mismatches)]
           [else (loop (+ i 1) (+ mismatches 1))]))]
      ;; If len1 is one greater than len2, check for one deletion from s1
      [(= len1 (+ len2 1))
       (let loop ([i 0] [j 0] [mismatches 0])
         (cond
           [(or (= i len1) (= j len2)) (= mismatches 1)]
           [(char=? (string-ref s1 i) (string-ref s2 j)) (loop (+ i 1) (+ j 1) mismatches)]
           [else
            (if (= mismatches 0)
                (loop (+ i 1) j (+ mismatches 1))
                #f)]))]
      ;; If len2 is one greater than len1, check for one insertion into s1 (deletion from s2)
      [(= len2 (+ len1 1))
       (let loop ([i 0] [j 0] [mismatches 0])
         (cond
           [(or (= i len1) (= j len2)) (= mismatches 1)]
           [(char=? (string-ref s1 i) (string-ref s2 j)) (loop (+ i 1) (+ j 1) mismatches)]
           [else
            (if (= mismatches 0)
                (loop i (+ j 1) (+ mismatches 1))
                #f)]))]
      [else #f])))

(define (check-fuzzy-search dictionary target)
  (ormap (lambda (dict-word)
           (or (string=? dict-word target)
               (is-one-edit-distance dict-word target)))
         dictionary))