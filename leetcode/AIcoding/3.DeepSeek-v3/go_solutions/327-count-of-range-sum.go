func countRangeSum(nums []int, lower int, upper int) int {
    n := len(nums)
    sum := make([]int64, n+1)
    for i := 0; i < n; i++ {
        sum[i+1] = sum[i] + int64(nums[i])
    }
    return mergeSort(sum, 0, n+1, lower, upper)
}

func mergeSort(sum []int64, left, right int, lower, upper int) int {
    if right-left <= 1 {
        return 0
    }
    mid := (left + right) / 2
    count := mergeSort(sum, left, mid, lower, upper) + mergeSort(sum, mid, right, lower, upper)
    j, k := mid, mid
    t := make([]int64, right-left)
    r := 0
    for i := left; i < mid; i++ {
        for j < right && sum[j]-sum[i] < int64(lower) {
            j++
        }
        for k < right && sum[k]-sum[i] <= int64(upper) {
            k++
        }
        count += k - j
    }
    i, j := left, mid
    for i < mid && j < right {
        if sum[i] <= sum[j] {
            t[r] = sum[i]
            r++
            i++
        } else {
            t[r] = sum[j]
            r++
            j++
        }
    }
    for i < mid {
        t[r] = sum[i]
        r++
        i++
    }
    for j < right {
        t[r] = sum[j]
        r++
        j++
    }
    for i := left; i < right; i++ {
        sum[i] = t[i-left]
    }
    return count
}