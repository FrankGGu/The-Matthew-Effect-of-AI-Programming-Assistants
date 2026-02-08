func smallestDivisor(nums []int, threshold int) int {
    left, right := 1, 1000000
    ans := right
    for left <= right {
        mid := left + (right-left)/2
        sum := 0
        for _, num := range nums {
            sum += (num + mid - 1) / mid
        }
        if sum <= threshold {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return ans
}