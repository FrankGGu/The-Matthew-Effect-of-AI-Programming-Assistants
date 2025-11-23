package main

func findLongestSubsequence(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    maxLen := 0
    for num, freq := range count {
        if otherFreq, ok := count[num+1]; ok {
            maxLen = max(maxLen, freq+otherFreq)
        }
    }
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}