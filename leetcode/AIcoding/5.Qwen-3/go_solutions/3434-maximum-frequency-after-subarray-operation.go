package main

func maxFrequency(nums []int, key int) int {
    freq := make(map[int]int)
    maxFreq := 0
    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == key {
            freq[nums[i+1]]++
            if freq[nums[i+1]] > maxFreq {
                maxFreq = freq[nums[i+1]]
            }
        }
    }
    return maxFreq
}