package main

func countSmaller(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    indexes := make([]int, n)
    for i := range indexes {
        indexes[i] = i
    }
    temp := make([]int, n)
    mergeSort(nums, indexes, 0, n-1, temp, res)
    return res
}

func mergeSort(nums []int, indexes []int, left, right int, temp []int, res []int) {
    if left >= right {
        return
    }
    mid := left + (right-left)/2
    mergeSort(nums, indexes, left, mid, temp, res)
    mergeSort(nums, indexes, mid+1, right, temp, res)
    merge(nums, indexes, left, mid, right, temp, res)
}

func merge(nums []int, indexes []int, left, mid, right int, temp []int, res []int) {
    for i := left; i <= right; i++ {
        temp[i] = indexes[i]
    }
    i := left
    j := mid + 1
    k := left
    for i <= mid && j <= right {
        if nums[temp[i]] <= nums[temp[j]] {
            indexes[k] = temp[i]
            i++
        } else {
            indexes[k] = temp[j]
            j++
            res[temp[j-1]] += mid - i + 1
        }
        k++
    }
    for i <= mid {
        indexes[k] = temp[i]
        i++
        k++
    }
    for j <= right {
        indexes[k] = temp[j]
        j++
        k++
    }
}