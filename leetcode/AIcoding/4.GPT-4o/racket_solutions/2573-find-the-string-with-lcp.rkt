(define (find-the-string lcp)
  (define n (length lcp))
  (define matrix (make-vector n (lambda () (make-vector n 0))))

  (for ((i (in-range n)))
    (for ((j (in-range n)))
      (if (= i j)
          (vector-set! (vector-ref matrix i) j n)
          (vector-set! (vector-ref matrix i) j (min (vector-ref (vector-ref lcp i) j) 
                                                    (vector-ref (vector-ref matrix i) (- j 1)) 
                                                    (vector-ref (vector-ref matrix (- i 1)) j) 
                                                    (vector-ref (vector-ref matrix (- i 1)) (- j 1)))))))

  (define result "")
  (for ((i (in-range n)))
    (for ((j (in-range n)))
      (if (= (vector-ref (vector-ref matrix i) j) n)
          (set! result (string-append result (string (char->integer (vector-ref lcp i j))))))))

  result)

(find-the-string (vector (vector 0 1 1) (vector 1 0 1) (vector 1 1 0)))