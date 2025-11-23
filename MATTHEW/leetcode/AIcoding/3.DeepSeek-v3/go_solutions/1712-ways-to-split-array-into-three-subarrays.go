func waysToSplit(nums []int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    res := 0
    mod := int(1e9 + 7)

    for i := 1; i < n-1; i++ {
        leftSum := prefix[i]
        low := i + 1
        high := n - 1
        left := -1
        right := -1

        // Find the smallest mid where midSum >= leftSum
        l, r := i+1, n-1
        for l <= r {
            mid := (l + r) / 2
            midSum := prefix[mid] - prefix[i]
            if midSum >= leftSum {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        left = l

        // Find the largest mid where rightSum >= midSum
        l, r = i+1, n-1
        for l <= r {
            mid := (l + r) / 2
            midSum := prefix[mid] - prefix[i]
            rightSum := prefix[n] - prefix[mid]
            if rightSum >= midSum {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        right = r

        if left <= right && left <= n-1 && right >= i+1 {
            res += right - left + 1
            res %= mod
        }
    }

    return res
}