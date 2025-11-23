func hasTrailingZeros(nums []int) bool {
    evenCount := 0
    for _, num := range nums {
        if num%2 == 0 {
            evenCount++
            if evenCount >= 2 {
                return true
            }
        }
    }
    return false
}