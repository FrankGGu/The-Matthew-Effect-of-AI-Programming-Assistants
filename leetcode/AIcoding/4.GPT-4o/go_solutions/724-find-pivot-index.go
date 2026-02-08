func pivotIndex(nums []int) int {
    total := 0
    leftSum := 0

    for _, num := range nums {
        total += num
    }

    for i, num := range nums {
        if leftSum == total-leftSum-num {
            return i
        }
        leftSum += num
    }

    return -1
}