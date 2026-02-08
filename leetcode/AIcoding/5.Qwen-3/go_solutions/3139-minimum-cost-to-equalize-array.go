package main

func minCostToEqualize(nums []int, cost []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    maxFreq := 0
    for _, v := range freq {
        if v > maxFreq {
            maxFreq = v
        }
    }
    totalCost := 0
    for i := 0; i < n; i++ {
        if freq[nums[i]] != maxFreq {
            totalCost += cost[i]
        }
    }
    return totalCost
}