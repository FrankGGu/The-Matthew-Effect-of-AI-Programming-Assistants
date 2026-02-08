(define (toggleBulbs n presses)
  (if (zero? presses)
      (if (even? n) 1 0)
      (if (even? presses)
          (if (even? n) (add1 (/ n 2)) (/ n 2))
          (if (even? n) (/ (+ n 1) 2) (add1 (/ n 2)))))))

(define (bulbSwitch n presses)
  (toggleBulbs n presses))