(define (palindrome-dfs? root s)
  (define (dfs node path)
    (if (null? node)
        (if (equal? (string-length path) (string-length s))
            (equal? (string-append path) (string-append (string-reverse path)))
            #f)
        (begin
          (dfs (node-left node) (string-append path (string (node-value node))))
          (dfs (node-right node) (string-append path (string (node-value node)))))))
  (dfs root ""))

(define (isPalindrome s)
  (let ([root (build-tree s)]) ; build-tree should be defined based on the input string
    (palindrome-dfs? root s)))