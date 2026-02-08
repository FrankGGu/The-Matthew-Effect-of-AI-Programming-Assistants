func maxSumOfThreeSubarrays(nums []int, k int) []int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    left := make([]int, n)
    maxSum := 0
    for i := k - 1; i < n; i++ {
        sum := prefix[i+1] - prefix[i+1-k]
        if sum > maxSum {
            maxSum = sum
            left[i] = i - k + 1
        } else {
            left[i] = left[i-1]
        }
    }

    right := make([]int, n)
    maxSum = 0
    for i := n - k; i >= 0; i-- {
        sum := prefix[i+k] - prefix[i]
        if sum >= maxSum {
            maxSum = sum
            right[i] = i
        } else {
            right[i] = right[i+1]
        }
    }

    res := make([]int, 3)
    maxSum = 0
    for i := k; i <= n-2*k; i++ {
        l := left[i-1]
        r := right[i+k]
        sum := (prefix[l+k] - prefix[l]) + (prefix[i+k] - prefix[i]) + (prefix[r+k] - prefix[r])
        if sum > maxSum {
            maxSum = sum
            res[0], res[1], res[2] = l, i, r
        }
    }
    return res
}