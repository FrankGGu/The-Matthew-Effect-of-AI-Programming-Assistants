func countKDivisibleSubarrays(nums []int, k int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = (prefix[i] + nums[i]) % k
    }

    count := make(map[int]int)
    count[0] = 1
    total := 0

    for i := 1; i <= n; i++ {
        total += count[prefix[i]]
        count[prefix[i]]++
    }

    return total
}