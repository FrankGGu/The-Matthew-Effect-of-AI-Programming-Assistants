package main

func differenceOfSums(nums []int, m int) int {
    sumDiv := 0
    sumNonDiv := 0
    for _, num := range nums {
        if num%m == 0 {
            sumDiv += num
        } else {
            sumNonDiv += num
        }
    }
    return sumNonDiv - sumDiv
}