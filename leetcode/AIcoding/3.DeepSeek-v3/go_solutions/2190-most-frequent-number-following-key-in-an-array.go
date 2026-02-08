func mostFrequent(nums []int, key int) int {
    freq := make(map[int]int)
    maxFreq := 0
    result := 0

    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == key {
            target := nums[i+1]
            freq[target]++
            if freq[target] > maxFreq {
                maxFreq = freq[target]
                result = target
            }
        }
    }

    return result
}