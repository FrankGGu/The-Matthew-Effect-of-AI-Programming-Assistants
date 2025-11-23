package main

func maxSubarrays(arr []int) int {
    count := 0
    currentSum := 0
    for i := 0; i < len(arr); i++ {
        currentSum += arr[i]
        if currentSum == 0 {
            count++
            currentSum = 0
        }
    }
    return count
}