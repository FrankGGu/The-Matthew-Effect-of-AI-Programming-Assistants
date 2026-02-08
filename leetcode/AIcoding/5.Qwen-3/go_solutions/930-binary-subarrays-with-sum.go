package main

func numSubarraysWithSum(nums []int, k int) int {
    count := 0
    sum := 0
    prefixSum := make(map[int]int)
    prefixSum[0] = 1

    for _, num := range nums {
        sum += num
        if v, ok := prefixSum[sum-k]; ok {
            count += v
        }
        prefixSum[sum]++
    }

    return count
}