func minimumSize(nums []int, maxOperations int) int {
    left, right := 1, 0
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left)/2
        ops := 0
        for _, num := range nums {
            ops += (num - 1) / mid
        }
        if ops > maxOperations {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}