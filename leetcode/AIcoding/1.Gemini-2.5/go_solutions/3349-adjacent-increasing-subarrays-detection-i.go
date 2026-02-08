func canBeSplit(nums []int) bool {
    n := len(nums)
    if n < 2 {
        return false
    }

    isPrefixIncreasing := make([]bool, n+1)
    isPrefixIncreasing[0] = true // An empty prefix is considered increasing
    if n > 0 {
        isPrefixIncreasing[1] = true // A single-element prefix is considered increasing
    }
    for i := 2; i <= n; i++ {
        if isPrefixIncreasing[i-1] && nums[i-2] < nums[i-1] {
            isPrefixIncreasing[i] = true
        } else {
            isPrefixIncreasing[i] = false
        }
    }

    isSuffixIncreasing := make([]bool, n+1)
    isSuffixIncreasing[n] = true // An empty suffix is considered increasing
    if n > 0 {
        isSuffixIncreasing[n-1] = true // A single-element suffix is considered increasing
    }
    for i := n - 2; i >= 0; i-- {
        if isSuffixIncreasing[i+1] && nums[i] < nums[i+1] {
            isSuffixIncreasing[i] = true
        } else {
            isSuffixIncreasing[i] = false
        }
    }

    for k := 1; k < n; k++ {
        // Check if nums[0...k-1] (first subarray) is increasing
        // AND nums[k...n-1] (second subarray) is increasing
        if isPrefixIncreasing[k] && isSuffixIncreasing[k] {
            return true
        }
    }

    return false
}