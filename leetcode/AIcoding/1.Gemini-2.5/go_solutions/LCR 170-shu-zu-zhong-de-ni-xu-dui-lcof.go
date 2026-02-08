func reversePairs(nums []int) int {
    return mergeSortAndCount(nums, 0, len(nums)-1)
}

func mergeSortAndCount(nums []int, low, high int) int {
    if low >= high {
        return 0
    }

    mid := low + (high-low)/2
    count := mergeSortAndCount(nums, low, mid) + mergeSortAndCount(nums, mid+1, high)

    // Count reverse pairs where nums[i] is in left half and nums[j] is in right half
    j := mid + 1
    for i := low; i <= mid; i++ {
        for j <= high && int64(nums[i]) > 2*int64(nums[j]) {
            j++
        }
        count += (j - (mid + 1))
    }

    // Merge the two sorted halves
    temp := make([]int, high-low+1)
    p1 := low
    p2 := mid + 1
    k := 0

    for p1 <= mid && p2 <= high {
        if nums[p1] <= nums[p2] {
            temp[k] = nums[p1]
            p1++
        } else {
            temp[k] = nums[p2]
            p2++
        }
        k++
    }

    for p1 <= mid {
        temp[k] = nums[p1]
        p1++
        k++
    }

    for p2 <= high {
        temp[k] = nums[p2]
        p2++
        k++
    }

    for i := low; i <= high; i++ {
        nums[i] = temp[i-low]
    }

    return count
}