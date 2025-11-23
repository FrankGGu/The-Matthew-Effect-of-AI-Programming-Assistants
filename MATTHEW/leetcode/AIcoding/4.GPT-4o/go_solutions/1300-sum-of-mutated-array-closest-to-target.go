func findBestValue(arr []int, target int) int {
    left, right := 0, 100000
    for left < right {
        mid := (left + right) / 2
        if getSum(arr, mid) < target {
            left = mid + 1
        } else {
            right = mid
        }
    }

    if getSum(arr, left) - target <= target - getSum(arr, left-1) {
        return left
    }
    return left - 1
}

func getSum(arr []int, value int) int {
    sum := 0
    for _, num := range arr {
        if num > value {
            sum += value
        } else {
            sum += num
        }
    }
    return sum
}