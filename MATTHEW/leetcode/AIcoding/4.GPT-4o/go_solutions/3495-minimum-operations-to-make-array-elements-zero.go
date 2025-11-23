func minimumOperations(nums []int) int {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        if num > 0 {
            numSet[num] = struct{}{}
        }
    }
    return len(numSet)
}