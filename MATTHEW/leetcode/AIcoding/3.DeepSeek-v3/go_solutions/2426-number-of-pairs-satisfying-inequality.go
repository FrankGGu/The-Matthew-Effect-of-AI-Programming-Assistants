func numberOfPairs(nums1 []int, nums2 []int, diff int) int64 {
    n := len(nums1)
    arr := make([]int, n)
    for i := 0; i < n; i++ {
        arr[i] = nums1[i] - nums2[i]
    }

    var count int64
    var mergeSort func([]int) []int
    mergeSort = func(a []int) []int {
        if len(a) <= 1 {
            return a
        }
        mid := len(a) / 2
        left := mergeSort(a[:mid])
        right := mergeSort(a[mid:])

        i, j := 0, 0
        for i < len(left) && j < len(right) {
            if left[i] <= right[j] + diff {
                count += int64(len(right) - j)
                i++
            } else {
                j++
            }
        }

        res := make([]int, 0, len(left)+len(right))
        i, j = 0, 0
        for i < len(left) && j < len(right) {
            if left[i] < right[j] {
                res = append(res, left[i])
                i++
            } else {
                res = append(res, right[j])
                j++
            }
        }
        res = append(res, left[i:]...)
        res = append(res, right[j:]...)
        return res
    }
    mergeSort(arr)
    return count
}