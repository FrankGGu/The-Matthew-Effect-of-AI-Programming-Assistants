func minimizedMaximum(n int, quantities []int) int {
    left, right := 1, max(quantities)
    for left < right {
        mid := left + (right-left)/2
        if canDistribute(quantities, n, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canDistribute(quantities []int, n, maxProducts int) bool {
    totalStores := 0
    for _, quantity := range quantities {
        totalStores += (quantity + maxProducts - 1) / maxProducts
    }
    return totalStores <= n
}

func max(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }
    return maxNum
}