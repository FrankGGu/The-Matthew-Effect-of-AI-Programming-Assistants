package main

func divideBooks(books []int, k int) int {
    left := 0
    right := len(books)

    for left < right {
        mid := (left + right) / 2
        cnt := 1
        current := 0

        for _, book := range books {
            if current+book > mid {
                cnt++
                current = book
            } else {
                current += book
            }
        }

        if cnt <= k {
            right = mid
        } else {
            left = mid + 1
        }
    }

    return left
}