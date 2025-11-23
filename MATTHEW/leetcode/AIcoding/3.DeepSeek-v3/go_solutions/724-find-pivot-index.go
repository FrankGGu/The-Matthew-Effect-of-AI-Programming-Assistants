func pivotIndex(nums []int) int {
    total := 0
    for _, num := range nums {
        total += num
    }

    leftSum := 0
    for i, num := range nums {
        if leftSum == total - leftSum - num {
            return i
        }
        leftSum += num
    }
    return -1
}