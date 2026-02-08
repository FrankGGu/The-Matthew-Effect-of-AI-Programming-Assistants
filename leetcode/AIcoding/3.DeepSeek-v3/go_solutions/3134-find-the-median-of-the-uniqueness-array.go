func medianOfUniquenessArray(nums []int) float64 {
    n := len(nums)
    totalSubarrays := n * (n + 1) / 2
    k := (totalSubarrays + 1) / 2

    low, high := 1, n
    for low < high {
        mid := low + (high-low)/2
        if countSubarraysWithAtMostKDistinct(nums, mid) < k {
            low = mid + 1
        } else {
            high = mid
        }
    }
    return float64(low)
}

func countSubarraysWithAtMostKDistinct(nums []int, k int) int {
    count := 0
    freq := make(map[int]int)
    left := 0
    for right := 0; right < len(nums); right++ {
        freq[nums[right]]++
        for len(freq) > k {
            freq[nums[left]]--
            if freq[nums[left]] == 0 {
                delete(freq, nums[left])
            }
            left++
        }
        count += right - left + 1
    }
    return count
}