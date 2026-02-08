(define (maximize-active-section-with-trade-i nums)
  (if (null? nums)
      0
      (let* ((first-num (car nums)))
        (let loop ((rest-nums (cdr nums))
                   (max-ending-here-no-flip first-num)
                   (max-ending-here-with-flip (- first-num))
                   (global-max (max first-num (- first-num))))
          (if (null? rest-nums)
              global-max
              (let* ((current-num (car rest-nums))
                     (prev-max-ending-here-no-flip max-ending-here-no-flip)

                     (new-max-ending-here-no-flip (max current-num
                                                         (+ prev-max-ending-here-no-flip current-num)))

                     (option1-cmwf (+ max-ending-here-with-flip current-num))
                     (option2-cmwf (+ prev-max-ending-here-no-flip (- current-num)))
                     (option3-cmwf (- current-num))
                     (new-max-ending-here-with-flip (max option1-cmwf
                                                         option2-cmwf
                                                         option3-cmwf))

                     (new-global-max (max global-max
                                          new-max-ending-here-no-flip
                                          new-max-ending-here-with-flip)))
                (loop (cdr rest-nums)
                      new-max-ending-here-no-flip
                      new-max-ending-here-with-flip
                      new-global-max)))))))