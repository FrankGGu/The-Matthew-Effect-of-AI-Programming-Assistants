#lang racket

(define (mask-pi s)
  (cond
    ;; Check if it's an email (contains '@')
    ((string-contains? s "@")
     (let* ([s-lower (string-downcase s)]
            [at-index (string-find-first-occurrence s-lower "@")]
            [local-name (substring s-lower 0 at-index)]
            [domain-name (substring s-lower (+ at-index 1))])
       (string-append
        (substring local-name 0 1)
        "*****"
        (substring local-name (- (string-length local-name) 1))
        "@"
        domain-name)))

    ;; Otherwise, it's a phone number
    (else
     (let* ([digits (string-filter char-numeric? s)]
            [len (string-length digits)]
            [last-four (substring digits (- len 4))])
       (cond
         ;; 10 digits (no country code)
         [(= len 10)
          (string-append "***-***-" last-four)]
         ;; 11, 12, or 13 digits (with country code)
         [else
          (let ([country-code-len (- len 10)])
            (string-append
             "+"
             (make-string country-code-len #\*)
             "-***-***-"
             last-four))])))))