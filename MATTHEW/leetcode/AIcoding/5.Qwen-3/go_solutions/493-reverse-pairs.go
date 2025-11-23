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
    count += merge(nums, left, mid, right)
    return count
}

func merge(nums []int, left, mid, right int) int {
    i, j, k := left, mid+1, left
    count := 0
    for i <= mid && j <= right {
        if nums[i] > nums[j] {
            count += mid - i + 1
            j++
        } else {
            k++
            i++
        }
    }
    i, j = left, mid+1
    temp := make([]int, right-left+1)
    k = 0
    for i <= mid && j <= right {
        if nums[i] <= nums[j] {
            temp[k] = nums[i]
            i++
        } else {
            temp[k] = nums[j]
            j++
        }
        k++
    }
    for i <= mid {
        temp[k] = nums[i]
        i++
        k++
    }
    for j <= right {
        temp[k] = nums[j]
        j++
        k++
    }
    for i := 0; i < len(temp); i++ {
        nums[left+i] = temp[i]
    }
    return count
}