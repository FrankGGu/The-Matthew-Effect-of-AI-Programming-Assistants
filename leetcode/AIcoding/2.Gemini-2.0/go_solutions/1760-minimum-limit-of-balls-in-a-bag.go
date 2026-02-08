func minimumSize(nums []int, maxOperations int) int {
    left, right := 1, 1000000000
    for left < right {
        mid := left + (right-left)/2
        ops := 0
        for _, num := range nums {
            ops += (num - 1) / mid
        }
        if ops <= maxOperations {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}