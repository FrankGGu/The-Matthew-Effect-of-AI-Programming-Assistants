func countInversions(arr []int) int {
    if len(arr) < 2 {
        return 0
    }
    temp := make([]int, len(arr))
    return mergeSort(arr, temp, 0, len(arr)-1)
}

func mergeSort(arr, temp []int, left, right int) int {
    if left >= right {
        return 0
    }
    mid := left + (right-left)/2
    invCount := mergeSort(arr, temp, left, mid)
    invCount += mergeSort(arr, temp, mid+1, right)
    invCount += merge(arr, temp, left, mid, right)
    return invCount
}

func merge(arr, temp []int, left, mid, right int) int {
    i := left
    j := mid + 1
    k := left
    invCount := 0

    for i <= mid && j <= right {
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

    for j <= right {
        temp[k] = arr[j]
        j++
        k++
    }

    for i := left; i <= right; i++ {
        arr[i] = temp[i]
    }

    return invCount
}

func InversionCount(nums []int) int {
    return countInversions(nums)
}