(define (equations-satisfiable equations)
  (define num-vars 26)
  (define parent (make-vector num-vars))

  (for ([i (in-range num-vars)])
    (vector-set! parent i i))

  (define (find i)
    (cond
      [(= (vector-ref parent i) i) i]
      [else
       (let ([root (find (vector-ref parent i))])
         (vector-set! parent i root)
         root)]))

  (define (union! i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (vector-set! parent root-i root-j))))

  (for ([eq-str equations])
    (when (string=? (substring eq-str 1 3) "==")
      (let ([var1 (- (char->integer (string-ref eq-str 0)) (char->integer #\a))]
            [var2 (- (char->integer (string-ref eq-str 3)) (char->integer #\a))])
        (union! var1 var2))))

  (let loop ([remaining-equations equations])
    (cond
      [(empty? remaining-equations) #t]
      [else
       (let* ([eq-str (first remaining-equations)]
              [op (substring eq-str 1 3)])
         (if (string=? op "!=")
             (let ([var1 (- (char->integer (string-ref eq-str 0)) (char->integer #\a))]
                   [var2 (- (char->integer (string-ref eq-str 3)) (char->integer #\a))])
               (if (= (find var1) (find var2))
                   #f
                   (loop (rest remaining-equations))))
             (loop (rest remaining-equations))))]))