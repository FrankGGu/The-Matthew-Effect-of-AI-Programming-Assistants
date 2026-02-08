func waysToSplit(nums []int) int {
    const mod = 1e9 + 7
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = prefix[i-1] + nums[i-1]
    }

    count := 0
    j, k := 0, 0
    for i := 1; i < n; i++ {
        for j < i && prefix[j+1] < prefix[i+1]-prefix[i] {
            j++
        }
        for k < i && prefix[k+1] < prefix[i+1] {
            k++
        }
        count = (count + k - j) % mod
    }

    return count
}