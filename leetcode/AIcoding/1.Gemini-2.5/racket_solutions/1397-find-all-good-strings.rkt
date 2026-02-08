#lang racket

(define MOD 1000000007)

(define (compute-lps evil)
  (let* ((m (string-length evil))
         (lps (make-vector m 0)))
    (when (> m 0)
      (let loop ((len 0) (i 1))
        (when (< i m)
          (cond
            ((char=? (string-ref evil i) (string-ref evil len))
             (set! len (+ len 1))
             (vector-set! lps i len)
             (loop len (+ i 1)))
            ((> len 0)
             (set! len (vector-ref lps (- len 1)))
             (loop len i))
            (else
             (vector-set! lps i 0)
             (loop 0 (+ i 1)))))))
    lps))

(define (precompute-kmp-transitions evil lps)
  (let* ((m (string-length evil))
         (transition-table (make-vector m #f))) 
    (for ((k (range m)))
      (vector-set! transition-table k (make-vector 26 #f))
      (for ((char-digit (range 26)))
        (let* ((char-to-append (integer->char (+ char-digit (char->integer #\a))))
               (next-k
                (let loop ((current-k k))
                  (cond
                    ((char=? char-to-append (string-ref evil current-k))
                     (+ current-k 1))
                    ((> current-k 0)
                     (loop (vector-ref lps (- current-k 1))))
                    (else
                     (if (char=? char-to-append (string-ref evil 0))
                         1
                         0))))))
          (vector-set! (vector-ref transition-table k) char-digit next-k))))
    transition-table))

(define (find-all-good-strings n s1 s2 evil)
  (let* ((evil-len (string-length evil))
         (lps (compute-lps evil))
         (kmp-transition-table (precompute-kmp-transitions evil lps))
         (memo (make-hash)))

    (define (dp index tight-s1 tight-s2 evil-match-len)
      (let ((key (list index tight-s1 tight-s2 evil-match-len)))
        (hash-ref! memo key
                   (lambda ()
                     (cond
                       ((= evil-match-len evil-len)
                        0)
                       ((= index n)
                        1)
                       (else
                        (let* ((lower-bound-char (if tight-s1 (string-ref s1 index) #\a))
                               (upper-bound-char (if tight-s2 (string-ref s2 index) #\z))
                               (lower-bound-digit (- (char->integer lower-bound-char) (char->integer #\a)))
                               (upper-bound-digit (- (char->integer upper-bound-char) (char->integer #\a))))
                               (ans 0))
                          (for ((digit (range lower-bound-digit (add1 upper-bound-digit))))
                            (let* ((new-evil-match-len (vector-ref (vector-ref kmp-transition-table evil-match-len) digit)))
                              (set! ans
                                    (modulo (+ ans
                                                (dp (+ index 1)
                                                    (and tight-s1 (= digit lower-bound-digit))
                                                    (and tight-s2 (= digit upper-bound-digit))
                                                    new-evil-match-len))
                                            MOD))))
                          ans)))))))

    (dp 0 #t #t 0)))