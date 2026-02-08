func reversePairs(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    return mergeSort(nums, 0, len(nums)-1)
}

func mergeSort(nums []int, left, right int) int {
    if left >= right {
        return 0
    }
    mid := left + (right-left)/2
    count := mergeSort(nums, left, mid) + mergeSort(nums, mid+1, right)

    j := mid + 1
    for i := left; i <= mid; i++ {
        for j <= right && nums[i] > 2*nums[j] {
            j++
        }
        count += j - (mid + 1)
    }

    merge(nums, left, mid, right)
    return count
}

func merge(nums []int, left, mid, right int) {
    temp := make([]int, right-left+1)
    i, j, k := left, mid+1, 0

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

    for p := 0; p < len(temp); p++ {
        nums[left+p] = temp[p]
    }
}