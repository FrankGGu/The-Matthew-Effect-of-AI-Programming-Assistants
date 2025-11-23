func smallestDivisor(nums []int, threshold int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    left := 1
    right := maxNum
    ans := maxNum

    for left <= right {
        mid := left + (right - left) / 2

        currentSum := 0
        for _, num := range nums {
            currentSum += (num + mid - 1) / mid
        }

        if currentSum <= threshold {
            ans = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return ans
}