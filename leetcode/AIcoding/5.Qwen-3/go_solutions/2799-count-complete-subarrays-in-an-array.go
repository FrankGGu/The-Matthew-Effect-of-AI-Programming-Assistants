package main

func countCompleteSubarrays(nums []int) int {
    unique := make(map[int]bool)
    for _, num := range nums {
        unique[num] = true
    }
    target := len(unique)
    count := 0
    left := 0
    freq := make(map[int]int)
    for right, num := range nums {
        freq[num]++
        for len(freq) == target {
            count += len(nums) - right
            freq[nums[left]]--
            if freq[nums[left]] == 0 {
                delete(freq, nums[left])
            }
            left++
        }
    }
    return count
}