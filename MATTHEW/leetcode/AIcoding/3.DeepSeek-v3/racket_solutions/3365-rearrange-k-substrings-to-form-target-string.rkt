#lang racket

(define/contract (can-rearrange-k_substrings s target k)
  (-> string? string? exact-integer? boolean?)
  (let* ([len_s (string-length s)]
         [len_t (string-length target)]
         [required_len (* k len_t)])
    (if (not (= (modulo len_s required_len) 0))
        #f
        (let ([count_s (make-hash)]
              [count_t (make-hash)])
          (for ([c (in-string target)])
            (hash-update! count_t c add1 (lambda () 0)))
          (for ([c (in-string s)])
            (hash-update! count_s c add1 (lambda () 0)))
          (for/fold ([possible #t])
                    ([(key val) (in-hash count_t)])
            (and possible
                 (let ([s_val (hash-ref count_s key (lambda () 0))])
                   (>= s_val (* k val)))))))))