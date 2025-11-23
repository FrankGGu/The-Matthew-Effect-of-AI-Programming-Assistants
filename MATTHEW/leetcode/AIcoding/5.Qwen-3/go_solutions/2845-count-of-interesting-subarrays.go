package main

func countInterestingSubarrays(nums []int, k int) int {
    count := make(map[int]int)
    count[0] = 1
    result := 0
    currentSum := 0

    for _, num := range nums {
        if num%2 == 1 {
            currentSum++
        }
        result += count[(currentSum-k)%k]
        count[currentSum%k]++
    }

    return result
}