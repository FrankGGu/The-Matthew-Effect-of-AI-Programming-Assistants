(define (longest-string-chain words)
  (define (can-form-shorter s longer)
    (define len (string-length s))
    (define shorter-length (string-length longer))
    (and (= (+ 1 len) shorter-length)
         (let loop ((i 0) (j 0) (diff 0))
           (cond
             ((= i len) (= j shorter-length))
             ((= j shorter-length) #f)
             ((string-ref s i) = (string-ref longer j)
              (loop (+ i 1) (+ j 1) diff))
             (else
              (if (= diff 0)
                  (loop i (+ j 1) (+ diff 1))
                  #f))))))

  (define (build-chain word chains)
    (let ((prev-chains (filter (lambda (w) (can-form-shorter w word)) chains)))
      (if (null? prev-chains)
          1
          (+ 1 (apply max (map (lambda (w) (build-chain w prev-chains)) prev-chains))))))

  (define sorted-words (sort words string<?))
  (apply max (map (lambda (w) (build-chain w sorted-words)) sorted-words)))

(define (longestStringChain words)
  (longest-string-chain words))