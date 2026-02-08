func pivotArray(nums []int, pivot int) []int {
    left := []int{}
    middle := []int{}
    right := []int{}

    for _, num := range nums {
        if num < pivot {
            left = append(left, num)
        } else if num == pivot {
            middle = append(middle, num)
        } else {
            right = append(right, num)
        }
    }

    return append(append(left, middle...), right...)
}