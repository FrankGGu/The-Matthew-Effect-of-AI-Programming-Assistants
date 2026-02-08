(define (maximum-groups grades)
  (let* ((n (length grades))
         (sorted-grades (sort grades <)))
    (define (find-max-groups current-student-idx group-size prev-sum prev-count num-groups)
      (let ((required-students group-size))
        (if (> (+ current-student-idx required-students) n)
            num-groups
            (let* ((current-group-elements (take (drop sorted-grades current-student-idx) required-students))
                   (current-sum (apply + current-group-elements)))
              (if (and (> current-sum prev-sum)
                       (> required-students prev-count))
                  (find-max-groups (+ current-student-idx required-students)
                                   (+ group-size 1)
                                   current-sum
                                   required-students
                                   (+ num-groups 1))
                  num-groups)))))
    (find-max-groups 0 1 -1 0 0)))