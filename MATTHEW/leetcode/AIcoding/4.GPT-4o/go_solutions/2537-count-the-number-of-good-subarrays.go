func countGood(subarray []int) int {
    count := 0
    freq := make(map[int]int)
    left := 0

    for right := 0; right < len(subarray); right++ {
        freq[subarray[right]]++

        for freq[subarray[right]] > 1 {
            freq[subarray[left]]--
            if freq[subarray[left]] == 0 {
                delete(freq, subarray[left])
            }
            left++
        }

        count += right - left + 1
    }

    return count
}

func countGoodSubarrays(arr []int) int {
    return countGood(arr)
}