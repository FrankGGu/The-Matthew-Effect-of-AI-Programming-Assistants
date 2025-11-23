func mostFrequentEven(nums []int) int {
    freq := make(map[int]int)
    maxFreq := 0
    result := -1

    for _, num := range nums {
        if num%2 == 0 {
            freq[num]++
            if freq[num] > maxFreq || (freq[num] == maxFreq && num < result) {
                maxFreq = freq[num]
                result = num
            }
        }
    }

    return result
}