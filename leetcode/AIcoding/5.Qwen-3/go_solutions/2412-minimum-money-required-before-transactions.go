package main

func minimumMoney(transactions []int) int {
    maxDiff := 0
    total := 0
    for _, t := range transactions {
        if t > 0 {
            total += t
            if t > maxDiff {
                maxDiff = t
            }
        } else {
            total += t
        }
    }
    return total + maxDiff
}