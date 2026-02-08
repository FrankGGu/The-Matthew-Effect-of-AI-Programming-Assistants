(define (smallest-substring s)
  (define (helper s)
    (define n (string-length s))
    (define min-length (string-length s))
    (define start 0)
    (define count (make-vector 256 0))
    (define unique-chars 0)

    (for ((end (in-range n)))
      (let ((char (string-ref s end)))
        (if (= (vector-ref count (char->integer char)) 0)
            (set! unique-chars (+ unique-chars 1)))
        (vector-set! count (char->integer char) (+ 1 (vector-ref count (char->integer char))))

        (while (>= (vector-ref count (char->integer (string-ref s start))) 2)
          (vector-set! count (char->integer (string-ref s start)) 
                       (- (vector-ref count (char->integer (string-ref s start))) 1))
          (if (= (vector-ref count (char->integer (string-ref s start))) 0)
              (set! unique-chars (- unique-chars 1)))
          (set! start (+ start 1)))

        (if (= unique-chars 1)
            (set! min-length (min min-length (+ 1 (- end start)))))))

    (if (= min-length (string-length s))
        ""
        (substring s start (+ start min-length))))

  (helper s))