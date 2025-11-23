(define (reformat-date date)
  (define month-map
    (hash "Jan" "01" "Feb" "02" "Mar" "03" "Apr" "04" "May" "05" "Jun" "06"
          "Jul" "07" "Aug" "08" "Sep" "09" "Oct" "10" "Nov" "11" "Dec" "12"))

  (define parts (string-split date " "))
  (define day-str (list-ref parts 0))
  (define month-abbr (list-ref parts 1))
  (define year-str (list-ref parts 2))

  (define day-num-str
    (let* ((len (string-length day-str))
           (num-part (substring day-str 0 (- len 2)))
           (num (string->number num-part)))
      (if (< num 10)
          (format "0~a" num)
          (format "~a" num))))

  (define month-num-str (hash-ref month-map month-abbr))

  (string-append year-str "-" month-num-str "-" day-num-str))