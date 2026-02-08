package main

func findNumbers(nums []int) int {
    count := 0
    for _, num := range nums {
        digits := 0
        if num == 0 {
            digits = 1
        } else {
            for num != 0 {
                num /= 10
                digits++
            }
        }
        if digits%2 == 0 {
            count++
        }
    }
    return count
}