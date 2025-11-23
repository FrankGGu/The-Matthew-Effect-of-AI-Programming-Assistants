(define (length-of-lis nums)
  (define (bisect-left arr x)
    (let loop ([lo 0] [hi (vector-length arr)])
      (if (>= lo hi)
          lo
          (let ([mid (quotient (+ lo hi) 2)])
            (if (< (vector-ref arr mid) x)
                (loop (+ mid 1) hi)
                (loop lo mid))))))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (let loop ([i 0] [len 0])
      (cond [(= i (length nums)) len]
            [else
             (let ([pos (bisect-left dp (list-ref nums i))])
               (vector-set! dp pos (list-ref nums i))
               (loop (+ i 1) (max len pos)))])))
  (let ([dp (make-vector (length nums) 0)])
    (