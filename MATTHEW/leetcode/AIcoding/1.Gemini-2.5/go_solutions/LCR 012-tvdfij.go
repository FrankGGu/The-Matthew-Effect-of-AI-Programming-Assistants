func pivotIndex(nums []int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    leftSum := 0
    for i, num := range nums {
        if leftSum == totalSum-leftSum-num {
            return i
        }
        leftSum += num
    }

    return -1
}