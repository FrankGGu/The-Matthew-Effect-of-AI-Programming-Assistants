(define (is-valid code)
  (define len (string-length code))

  ;; Helper to check if a character is an uppercase English letter
  (define (is-upper-alpha char)
    (and (char>=? char #\A) (char<=? char #\Z)))

  ;; parse-tag-name: extracts TAG_NAME from `code` starting at `start-idx`.
  ;; A tag name consists of 1 to 9 uppercase English letters.
  ;; Returns (values tag-name end-idx-of-name) if valid, or #f otherwise.
  ;; `end-idx-of-name` is the index immediately after the last character of the tag name.
  (define (parse-tag-name start-idx)
    (let loop ((k start-idx) (name-len 0) (tag-name-chars '()))
      (cond
        ((>= k len) #f) ; Reached end of string unexpectedly
        ((is-upper-alpha (string-ref code k))
         (let ((new-name-len (+ name-len 1)))
           (if (> new-name-len 9)
               #f ; Tag name too long
               (loop (+ k 1) new-name-len (cons (string-ref code k) tag-name-chars)))))
        (else ; Not an uppercase letter, end of tag name
         (if (or (< name-len 1) (> name-len 9))
             #f ; Tag name too short or too long (should be caught by >9 check)
             (values (list->string (reverse tag-name-chars)) k))))))

  ;; parse-content: parses content within a tag, from `i` up to its matching closing tag.
  ;; `i`: current index in the `code` string.
  ;; `expected-tag-name`: the name of the tag whose closing tag we are looking for.
  ;; `tag-stack`: a list representing the stack of currently open tag names (for validation of nested tags).
  ;; Returns (values new-index #t) if successful, where `new-index` is the index
  ;; immediately after the expected closing tag. Returns #f if invalid.
  (define (parse-content i expected-tag-name tag-stack)
    (let loop ((current-idx i))
      (cond
        ((>= current-idx len) #f) ; Reached end of string without finding the expected closing tag

        ((char=? (string-ref code current-idx) #\<) ; Found a '<'
         (cond
           ;; CDATA section: <![CDATA[...]]>
           ((and (<= (+ current-idx 8) len) (string=? (substring code current-idx (+ current-idx 9)) "<![CDATA["))
            (if (null? tag-stack) #f ; CDATA cannot appear outside any tag content
                (let ((cdata-end-idx (string-index code "]]>" (+ current-idx 9))))
                  (if cdata-end-idx
                      (loop (+ cdata-end-idx 3)) ; Continue parsing after CDATA section
                      #f)))) ; CDATA end ']]>' not found or malformed

           ;; Closing tag: </TAG_NAME>
           ((and (< (+ current-idx 1) len) (char=? (string-ref code (+ current-idx 1)) #\/))
            (let-values (((tag-name end-idx) (parse-tag-name (+ current-idx 2))))
              (if (and tag-name (< end-idx len) (char=? (string-ref code end-idx) #\>))
                  (if (string=? tag-name expected-tag-name)
                      ;; Found the expected closing tag for the current level
                      (values (+ end-idx 1) #t)
                      #f) ; Mismatched closing tag
                  #f))) ; Invalid closing tag format

           ;; Opening tag: <TAG_NAME>
           (else
            (let-values (((tag-name end-idx) (parse-tag-name (+ current-idx 1))))
              (if (and tag-name (< end-idx len) (char=? (string-ref code end-idx) #\>))
                  ;; Valid opening tag, recursively parse its content
                  (let-values (((next-idx success?)
                                (parse-content (+ end-idx 1) tag-name (cons tag-name tag-stack))))
                    (if success?
                        (loop next-idx) ; Continue parsing content after inner tag
                        #f))) ; Inner tag content was invalid
              #f))) ; Invalid opening tag format
           ))

        ;; Plain text character (not '<')
        (else
         (if (null? tag-stack) #f ; Plain text cannot appear outside any tag content
             (loop (+ current-idx 1))))))) ; Consume plain text character

  ;; --- Main validation logic ---
  ;; 1. The string must not be empty.
  ;; 2. It must start with an opening tag '<TAG_NAME>'.
  ;; 3. The entire string must be enclosed within this single pair of matching tags.
  (if (or (zero? len) (not (char=? (string-ref code 0) #\<)))
      #f ; Empty string or does not start with '<'
      (let-values (((tag-name end-idx) (parse-tag-name 1)))
        (if (and tag-name (< end-idx len) (char=? (string-ref code end-idx) #\>))
            ;; Successfully parsed the initial opening tag
            (let-values (((final-idx success?)
                          (parse-content (+ end-idx 1) tag-name (list tag-name))))
              ;; The content must be valid, and `final-idx` must be equal to `len`
              ;; (meaning no extra characters after the top-level closing tag).
              (and success? (= final-idx len)))
            #f)))) ; Initial tag is malformed or invalid
)