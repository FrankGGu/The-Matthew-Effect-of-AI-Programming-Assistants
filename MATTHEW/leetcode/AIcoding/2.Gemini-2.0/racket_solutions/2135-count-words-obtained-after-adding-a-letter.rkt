(define (count-consistent-strings allowed words)
  (define allowed-set (set))
  (for ([c (string->list allowed)])
    (set-add! allowed-set c))

  (define (is-consistent? word)
    (for/and ([c (string->list word)])
      (set-member? allowed-set c)))

  (length (filter is-consistent? words)))

(define (word-subsets words1 words2)
  (define (char-counts word)
    (let ([counts (make-vector 26 0)])
      (for ([c (string->list word)])
        (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
      counts))

  (define (max-char-counts words)
    (let ([max-counts (make-vector 26 0)])
      (for ([word words])
        (let ([counts (char-counts word)])
          (for/list ([i (in-range 26)])
            (vector-set! max-counts i (max (vector-ref max-counts i) (vector-ref counts i))))))
      max-counts))

  (define target-counts (max-char-counts words2))

  (define (is-superset? word)
    (let ([counts (char-counts word)])
      (for/and ([i (in-range 26)])
        (>= (vector-ref counts i) (vector-ref target-counts i)))))

  (filter is-superset? words1))

(define (word-to-mask word)
  (let loop ([chars (string->list word)]
             [mask 0])
    (if (null? chars)
        mask
        (let ([c (car chars)])
          (loop (cdr chars) (bitwise-ior mask (arithmetic-shift 1 (- (char->integer c) (char->integer #\a)))))))))

(define (count-consistent-strings allowed words)
  (let ([allowed-set (string->set allowed)])
    (length (filter (lambda (word)
                       (string-for-all? word (lambda (c) (set-member? allowed-set c))))
                     words))))

(define (count-words-after-adding-one-letter startwords targetwords)
  (define start-set (set (map word-to-mask startwords)))
  (define (can-form? target-mask)
    (let loop ([i 0])
      (cond [(>= i 26) #f]
            [else
             (let ([new-mask (bitwise-xor target-mask (arithmetic-shift 1 i))])
               (if (and (bitwise-and target-mask (arithmetic-shift 1 i)) (set-member? start-set new-mask))
                   #t
                   (loop (+ i 1))))])))
  (length (filter can-form? (map word-to-mask targetwords))))