func wiggleSort(nums []int) {
    n := len(nums)
    sorted := make([]int, n)
    copy(sorted, nums)
    sort.Ints(sorted)

    mid := (n - 1) / 2
    for i, j, k := mid, n-1, 0; k < n; k++ {
        nums[k] = sorted[i]
        if k%2 == 0 {
            i--
        } else {
            j--
        }
    }
}