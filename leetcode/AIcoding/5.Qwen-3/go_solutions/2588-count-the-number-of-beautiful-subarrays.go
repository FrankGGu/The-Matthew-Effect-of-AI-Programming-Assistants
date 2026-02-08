package main

func numberOfBeautifulSubarrays(nums []int, k int) int {
    prefix := make(map[int]int)
    prefix[0] = 1
    count := 0
    xor := 0
    for _, num := range nums {
        xor ^= num
        if val, ok := prefix[xor^k]; ok {
            count += val
        }
        prefix[xor]++
    }
    return count
}