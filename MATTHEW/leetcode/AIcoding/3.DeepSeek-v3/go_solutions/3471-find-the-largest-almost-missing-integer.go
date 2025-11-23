func findLargestAlmostMissing(nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    maxMissing := -1
    for num := range numSet {
        if !numSet[num+1] {
            if num > maxMissing {
                maxMissing = num
            }
        }
    }
    return maxMissing
}