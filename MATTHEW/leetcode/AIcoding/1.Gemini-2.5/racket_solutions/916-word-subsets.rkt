(require racket/string)

(define (get-char-counts s)
  (define counts (make-vector 26 0))
  (for ([char (in-string s)])
    (define idx (- (char->integer char) (char->integer #\a)))
    (vector-set! counts idx (+ (vector-ref counts idx) 1)))
  counts)

(define (is-universal? a-counts max-b-counts)
  (for/and ([i (in-range 26)])
    (>= (vector-ref a-counts i) (vector-ref max-b-counts i))))

(define (word-subsets words1 words2)
  (define max-b-counts (make-vector 26 0))

  (for ([b-word words2])
    (define current-b-counts (get-char-counts b-word))
    (for ([i (in-range 26)])
      (vector-set! max-b-counts i (max (vector-ref max-b-counts i)
                                        (vector-ref current-b-counts i)))))

  (define result '())
  (for ([a-word words1])
    (define a-counts (get-char-counts a-word))
    (when (is-universal? a-counts max-b-counts)
      (set! result (cons a-word result))))
  (reverse result))