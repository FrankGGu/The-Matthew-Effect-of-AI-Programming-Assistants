func maximumCount(nums []int) int {
    posCount := 0
    negCount := 0

    for _, num := range nums {
        if num > 0 {
            posCount++
        } else if num < 0 {
            negCount++
        }
    }

    if posCount > negCount {
        return posCount
    }
    return negCount
}