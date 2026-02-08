package main

func countInversions(nums []int) int {
    return mergeSortAndCount(nums, 0, len(nums)-1)
}

func mergeSortAndCount(nums []int, left, right int) int {
    if left >= right {
        return 0
    }
    mid := left + (right-left)/2
    inversions := mergeSortAndCount(nums, left, mid)
    inversions += mergeSortAndCount(nums, mid+1, right)
    inversions += merge(nums, left, mid, right)
    return inversions
}

func merge(nums []int, left, mid, right int) int {
    i := left
    j := mid + 1
    k := left
    temp := make([]int, right-left+1)
    inversions := 0

    for i <= mid && j <= right {
        if nums[i] <= nums[j] {
            temp[k-left] = nums[i]
            i++
        } else {
            temp[k-left] = nums[j]
            inversions += mid - i + 1
            j++
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

    for m := left; m <= right; m++ {
        nums[m] = temp[m-left]
    }

    return inversions
}