func minimumSize(nums []int, maxOperations int) int {
    left, right := 1, 0
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left)/2
        operations := 0
        for _, num := range nums {
            operations += (num-1)/mid
        }
        if operations > maxOperations {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}