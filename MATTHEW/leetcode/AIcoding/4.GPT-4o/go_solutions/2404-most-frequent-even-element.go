func mostFrequentEven(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        if num%2 == 0 {
            freq[num]++
        }
    }

    maxFreq := 0
    result := -1
    for num, count := range freq {
        if count > maxFreq || (count == maxFreq && num < result) {
            maxFreq = count
            result = num
        }
    }

    return result
}