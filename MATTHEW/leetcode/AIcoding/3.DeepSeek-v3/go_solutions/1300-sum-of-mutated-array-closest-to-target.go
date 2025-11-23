func findBestValue(arr []int, target int) int {
    sort.Ints(arr)
    n := len(arr)
    prefix := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefix[i] = prefix[i-1] + arr[i-1]
    }
    left, right := 0, arr[n-1]
    best := right
    for left <= right {
        mid := left + (right-left)/2
        sum := calculateSum(arr, prefix, mid)
        if sum >= target {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    sumLow := calculateSum(arr, prefix, left-1)
    sumHigh := calculateSum(arr, prefix, left)
    if abs(sumLow-target) <= abs(sumHigh-target) {
        return left - 1
    }
    return left
}

func calculateSum(arr []int, prefix []int, value int) int {
    n := len(arr)
    idx := sort.Search(n, func(i int) bool { return arr[i] > value })
    sum := prefix[idx] + (n-idx)*value
    return sum
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}