#lang racket

(define (top-k-frequent-words words k)
  ;; 1. Count frequencies of each word
  (define word-counts (make-hash))
  (for-each (lambda (word)
              (hash-update! word-counts word add1 0))
            words)

  ;; 2. Convert hash table entries into a list of (word count) pairs
  (define word-count-pairs
    (hash-map word-counts (lambda (word count) (list word count))))

  ;; 3. Sort the list of (word count) pairs
  ;;    Sorting criteria:
  ;;    - Primary: Descending frequency (higher count comes first)
  ;;    - Secondary: Ascending alphabetical order (smaller string comes first)
  (define sorted-pairs
    (sort word-count-pairs
          (lambda (item1 item2)
            (let ((word1 (first item1))
                  (count1 (second item1))
                  (word2 (first item2))
                  (count2 (second item2)))
              (cond
                ((> count1 count2) #t) ; item1 has higher frequency, so it comes before item2
                ((< count1 count2) #f) ; item2 has higher frequency, so item1 does not come before item2
                ((string<? word1 word2) #t) ; frequencies are equal, item1 is alphabetically smaller, so it comes before item2
                (else #f)))))) ; frequencies are equal, item2 is alphabetically smaller or equal, so item1 does not come before item2

  ;; 4. Take the first K elements from the sorted list
  (define top-k-pairs (take sorted-pairs k))

  ;; 5. Extract only the words from the top K pairs
  (map first top-k-pairs))