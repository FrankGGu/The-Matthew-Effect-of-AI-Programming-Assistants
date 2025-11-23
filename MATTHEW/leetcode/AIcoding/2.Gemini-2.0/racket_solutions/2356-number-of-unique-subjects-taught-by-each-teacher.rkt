(define (unique-subjects-taught teachers)
  (map
   (lambda (teacher)
     (hash-map
      teacher
      (length (remove-duplicates (map (lambda (row) (hash-ref row 'subject_name))
                                     (filter (lambda (row) (= (hash-ref row 'teacher_id) (hash-ref teacher 'teacher_id)))
                                             teachers))))))
   (remove-duplicates (map (lambda (row) (hash-map 'teacher_id (hash-ref row 'teacher_id))) teachers))))