func maximumDifference(nums []int) int {
    evenCount := 0
    oddCount := 0
    for _, num := range nums {
        if num%2 == 0 {
            evenCount++
        } else {
            oddCount++
        }
    }
    return evenCount - oddCount
}