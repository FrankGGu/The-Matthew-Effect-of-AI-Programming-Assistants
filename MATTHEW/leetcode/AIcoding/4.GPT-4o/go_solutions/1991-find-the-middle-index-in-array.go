func findMiddleIndex(nums []int) int {
    totalSum := 0
    leftSum := 0

    for _, num := range nums {
        totalSum += num
    }

    for i, num := range nums {
        if leftSum == totalSum-leftSum-num {
            return i
        }
        leftSum += num
    }

    return -1
}