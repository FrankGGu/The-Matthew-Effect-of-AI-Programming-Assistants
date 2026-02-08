func smallestDivisor(nums []int, threshold int) int {
    left, right := 1, 1
    for _, num := range nums {
        if num > right {
            right = num
        }
    }

    for left < right {
        mid := left + (right-left)/2
        sum := 0
        for _, num := range nums {
            sum += (num + mid - 1) / mid
        }
        if sum > threshold {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}