func countMatchingSubarrays(nums []int, pattern []int) int {
    n := len(nums)
    m := len(pattern)
    if n <= m {
        return 0
    }

    // Convert nums to pattern between elements
    arr := make([]int, n-1)
    for i := 0; i < n-1; i++ {
        if nums[i+1] > nums[i] {
            arr[i] = 1
        } else if nums[i+1] == nums[i] {
            arr[i] = 0
        } else {
            arr[i] = -1
        }
    }

    // Build KMP prefix function for pattern
    prefix := make([]int, m)
    j := 0
    for i := 1; i < m; i++ {
        for j > 0 && pattern[i] != pattern[j] {
            j = prefix[j-1]
        }
        if pattern[i] == pattern[j] {
            j++
        }
        prefix[i] = j
    }

    // KMP search
    res := 0
    j = 0
    for i := 0; i < len(arr); i++ {
        for j > 0 && arr[i] != pattern[j] {
            j = prefix[j-1]
        }
        if arr[i] == pattern[j] {
            j++
        }
        if j == m {
            res++
            j = prefix[j-1]
        }
    }

    return res
}