func numSubarraysThatMatchPattern(arr []int, pattern []int) int {
    m, n := len(arr), len(pattern)
    ans := 0

    for i := 0; i <= m-n; i++ {
        match := true
        for j := 0; j < n; j++ {
            if arr[i+j] != pattern[j] {
                match = false
                break
            }
        }
        if match {
            ans++
        }
    }

    return ans
}