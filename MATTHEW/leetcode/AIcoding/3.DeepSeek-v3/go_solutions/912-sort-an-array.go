func sortArray(nums []int) []int {
    if len(nums) <= 1 {
        return nums
    }

    pivot := nums[len(nums)/2]
    var left, right, middle []int

    for _, num := range nums {
        if num < pivot {
            left = append(left, num)
        } else if num > pivot {
            right = append(right, num)
        } else {
            middle = append(middle, num)
        }
    }

    left = sortArray(left)
    right = sortArray(right)

    return append(append(left, middle...), right...)
}