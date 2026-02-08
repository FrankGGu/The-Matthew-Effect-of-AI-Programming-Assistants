func countGoodSubarrays(arr []int, k int) int64 {
    count := int64(0)
    freq := make(map[int]int)
    left := 0
    distinct := 0

    for right := 0; right < len(arr); right++ {
        if freq[arr[right]] == 0 {
            distinct++
        }
        freq[arr[right]]++

        for distinct > k {
            freq[arr[left]]--
            if freq[arr[left]] == 0 {
                distinct--
            }
            left++
        }

        count += int64(right - left + 1)
    }

    return count
}

func countGood(nums []int) int64 {
    return countGoodSubarrays(nums, 2) - countGoodSubarrays(nums, 1)
}