package main

func booksort(books []int) []int {
    left, right := 0, len(books)-1
    for left < right {
        for left < right && books[left]%2 == 1 {
            left++
        }
        for left < right && books[right]%2 == 0 {
            right--
        }
        if left < right {
            books[left], books[right] = books[right], books[left]
            left++
            right--
        }
    }
    return books
}