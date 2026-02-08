package main

func subarraySum(nums []int, k int) int {
    count := 0
    sum := 0
    prefixSum := make(map[int]int)
    prefixSum[0] = 1

    for _, num := range nums {
        sum += num
        if val, ok := prefixSum[sum - k]; ok {
            count += val
        }
        prefixSum[sum]++
    }

    return count
}