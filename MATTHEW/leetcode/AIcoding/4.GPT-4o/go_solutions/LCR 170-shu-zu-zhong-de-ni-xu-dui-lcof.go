func reversePairs(nums []int) int {
    if len(nums) < 2 {
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

    j := mid + 1
    for i := left; i <= mid; i++ {
        for j <= right && nums[i] > 2*nums[j] {
            j++
        }
        count += j - (mid + 1)
    }

    copy(temp[left:right+1], nums[left:right+1])
    i, j, k := left, mid+1, left
    for i <= mid && j <= right {
        if temp[i] <= temp[j] {
            nums[k] = temp[i]
            i++
        } else {
            nums[k] = temp[j]
            j++
        }
        k++
    }
    for i <= mid {
        nums[k] = temp[i]
        i++
        k++
    }
    for j <= right {
        nums[k] = temp[j]
        j++
        k++
    }

    return count
}