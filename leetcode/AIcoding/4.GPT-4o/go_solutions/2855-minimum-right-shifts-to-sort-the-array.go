func minimumRightShifts(nums []int) int {
    n := len(nums)
    minIndex := 0
    for i := 1; i < n; i++ {
        if nums[i] < nums[minIndex] {
            minIndex = i
        }
    }

    if minIndex == 0 {
        return 0
    }

    for i := 0; i < minIndex; i++ {
        if nums[i] > nums[i+1] {
            return -1
        }
    }

    return n - minIndex
}