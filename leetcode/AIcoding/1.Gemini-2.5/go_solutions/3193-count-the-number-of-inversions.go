func countInversions(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }
    temp := make([]int, n)
    return mergeSortAndCount(nums, temp, 0, n-1)
}

func mergeSortAndCount(arr []int, temp []int, low, high int) int {
    invCount := 0
    if low < high {
        mid := low + (high-low)/2
        invCount += mergeSortAndCount(arr, temp, low, mid)
        invCount += mergeSortAndCount(arr, temp, mid+1, high)
        invCount += mergeAndCount(arr, temp, low, mid, high)
    }
    return invCount
}

func mergeAndCount(arr []int, temp []int, low, mid, high int) int {
    i := low
    j := mid + 1
    k := low
    invCount := 0

    for i <= mid && j <= high {
        if arr[i] <= arr[j] {
            temp[k] = arr[i]
            i++
        } else {
            temp[k] = arr[j]
            invCount += (mid - i + 1)
            j++
        }
        k++
    }

    for i <= mid {
        temp[k] = arr[i]
        i++
        k++
    }

    for j <= high {
        temp[k] = arr[j]
        j++
        k++
    }

    for idx := low; idx <= high; idx++ {
        arr[idx] = temp[idx]
    }

    return invCount
}