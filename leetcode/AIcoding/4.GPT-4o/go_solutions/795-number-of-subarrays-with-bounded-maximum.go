func numSubarrayBoundedMax(nums []int, left int, right int) int {
    count := 0
    total := 0
    start := -1

    for i, num := range nums {
        if num > right {
            total = 0
            start = i
        } else if num >= left {
            total = i - start
        }
        count += total
    }

    return count
}