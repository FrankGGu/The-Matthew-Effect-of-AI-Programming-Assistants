func maxSumOfThreeSubarrays(nums []int, k int) []int {
    n := len(nums)
    sum := make([]int, n+1)
    left := make([]int, n)
    right := make([]int, n)
    res := make([]int, 3)

    for i := 0; i < n; i++ {
        sum[i+1] = sum[i] + nums[i]
    }

    max := 0
    for i := k; i <= n; i++ {
        if sum[i] - sum[i-k] > max {
            max = sum[i] - sum[i-k]
            left[i-1] = i - k
        } else {
            left[i-1] = left[i-2]
        }
    }

    max = 0
    for i := n - k; i >= 0; i-- {
        if sum[i+k] - sum[i] >= max {
            max = sum[i+k] - sum[i]
            right[i] = i
        } else {
            right[i] = right[i+1]
        }
    }

    maxSum := 0
    for i := k; i <= n - 2*k; i++ {
        l := left[i-1]
        r := right[i+k]
        total := (sum[l+k] - sum[l]) + (sum[i+k] - sum[i]) + (sum[r+k] - sum[r])
        if total > maxSum {
            maxSum = total
            res[0] = l
            res[1] = i
            res[2] = r
        }
    }

    return res
}