func countMatchingSubarrays(nums []int, pattern []int) int {
    n := len(nums)
    m := len(pattern)
    if n <= m {
        return 0
    }
    count := 0
    for i := 0; i <= n-m-1; i++ {
        match := true
        for k := 0; k < m; k++ {
            a := nums[i+k]
            b := nums[i+k+1]
            var expected int
            if a < b {
                expected = 1
            } else if a == b {
                expected = 0
            } else {
                expected = -1
            }
            if expected != pattern[k] {
                match = false
                break
            }
        }
        if match {
            count++
        }
    }
    return count
}