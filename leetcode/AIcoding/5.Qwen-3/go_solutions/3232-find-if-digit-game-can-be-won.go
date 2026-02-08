package main

func canWinDigitGame(nums []int) bool {
    count := make([]int, 10)
    for _, num := range nums {
        count[num]++
    }
    for i := 0; i < 10; i++ {
        if count[i] > 0 && count[i]%2 == 1 {
            return true
        }
    }
    return false
}