func getSubarrayBeauty(nums []int, k int, x int) []int {
    n := len(nums)
    result := make([]int, n-k+1)
    count := make([]int, 101)

    for i := 0; i < k; i++ {
        count[nums[i]+50]++
    }

    for i := 0; i <= n-k; i++ {
        if i > 0 {
            count[nums[i-1]+50]--
            count[nums[i+k-1]+50]++
        }

        total := 0
        for j := 0; j < 101; j++ {
            total += count[j]
            if total >= x {
                result[i] = j - 50
                break
            }
        }
        if total < x {
            result[i] = 0
        }
    }

    return result
}