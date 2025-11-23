func getSubarrayBeauty(nums []int, k int, x int) []int {
    n := len(nums)
    result := make([]int, n-k+1)
    freq := make([]int, 101)

    for i := 0; i < n; i++ {
        if nums[i] < 0 {
            freq[nums[i]+50]++
        }
        if i >= k-1 {
            count := 0
            beauty := 0
            for j := 0; j < 50; j++ {
                count += freq[j]
                if count >= x {
                    beauty = j - 50
                    break
                }
            }
            result[i-k+1] = beauty
            if nums[i-k+1] < 0 {
                freq[nums[i-k+1]+50]--
            }
        }
    }
    return result
}