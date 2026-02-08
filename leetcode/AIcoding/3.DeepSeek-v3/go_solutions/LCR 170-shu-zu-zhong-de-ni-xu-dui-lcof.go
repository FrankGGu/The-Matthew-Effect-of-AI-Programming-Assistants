func reversePairs(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    temp := make([]int, len(nums))
    return mergeSort(nums, temp, 0, len(nums)-1)
}

func mergeSort(nums, temp []int, left, right int) int {
    if left >= right {
        return 0
    }
    mid := left + (right-left)/2
    count := mergeSort(nums, temp, left, mid) + mergeSort(nums, temp, mid+1, right)
    i, j, k := left, mid+1, left
    for i <= mid && j <= right {
        if nums[i] <= nums[j] {
            temp[k] = nums[i]
            i++
        } else {
            temp[k] = nums[j]
            count += mid - i + 1
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
    for i := left; i <= right; i++ {
        nums[i] = temp[i]
    }
    return count
}