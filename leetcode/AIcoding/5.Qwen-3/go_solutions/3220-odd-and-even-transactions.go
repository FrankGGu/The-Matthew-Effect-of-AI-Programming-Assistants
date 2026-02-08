package main

func oddEvenTransactions(transactions []int) int {
    even := 0
    odd := 0
    for _, t := range transactions {
        if t%2 == 0 {
            even++
        } else {
            odd++
        }
    }
    return even - odd
}