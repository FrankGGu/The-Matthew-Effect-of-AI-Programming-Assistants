func countSmaller(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    indices := make([]int, n)

    for i := 0; i < n; i++ {
        indices[i] = i
    }

    var mergeSort func([]int, []int, int, int)
    mergeSort = func(arr []int, temp []int, left int, right int) {
        if left >= right {
            return
        }
        mid := left + (right-left)/2
        mergeSort(arr, temp, left, mid)
        mergeSort(arr, temp, mid+1, right)

        for i := left; i <= right; i++ {
            temp[i] = indices[i]
        }

        i, j, k := left, mid+1, left
        count := 0
        for i <= mid && j <= right {
            if arr[temp[i]] > arr[temp[j]] {
                count++
                j++
            } else {
                result[temp[i]] += count
                i++
            }
        }

        for i <= mid {
            result[temp[i]] += count
            i++
        }

        for k := left; k <= right; k++ {
            indices[k] = temp[k]
        }
    }

    mergeSort(nums, make([]int, n), 0, n-1)
    return result
}