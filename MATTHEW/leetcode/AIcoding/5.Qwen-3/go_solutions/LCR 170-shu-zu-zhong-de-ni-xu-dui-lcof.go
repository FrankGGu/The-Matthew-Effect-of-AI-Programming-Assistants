package main

func reversePairs(nums []int) int {
    return mergeSort(nums, 0, len(nums)-1)
}

func mergeSort(nums []int, left, right int) int {
    if left >= right {
        return 0
    }
    mid := left + (right-left)/2
    count := mergeSort(nums, left, mid) + mergeSort(nums, mid+1, right)
    return count + merge(nums, left, mid, right)
}

func merge(nums []int, left, mid, right int) int {
    i, j, k := left, mid+1, left
    count := 0
    temp := make([]int, right-left+1)
    for i <= mid && j <= right {
        if nums[i] > nums[j] {
            temp[k-left] = nums[j]
            j++
            count += mid - i + 1
        } else {
            temp[k-left] = nums[i]
            i++
        }
        k++
    }
    for i <= mid {
        temp[k-left] = nums[i]
        i++
        k++
    }
    for j <= right {
        temp[k-left] = nums[j]
        j++
        k++
    }
    for i := left; i <= right; i++ {
        nums[i] = temp[i-left]
    }
    return count
}