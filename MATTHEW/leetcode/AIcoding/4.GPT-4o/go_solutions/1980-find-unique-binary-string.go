func findDifferentBinaryString(nums []string) string {
    n := len(nums)
    unique := make([]byte, n)
    for i := 0; i < n; i++ {
        if nums[i][i] == '0' {
            unique[i] = '1'
        } else {
            unique[i] = '0'
        }
    }
    return string(unique)
}