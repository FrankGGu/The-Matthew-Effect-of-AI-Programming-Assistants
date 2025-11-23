import (
    "sort"
)

func minimizeMax(nums []int, p int) int {
    if p == 0 {
        return 0
    }
    sort.Ints(nums)
    left, right := 0, nums[len(nums)-1]-nums[0]

    for left < right {
        mid := left + (right-left)/2
        if countPairs(nums, mid) >= p {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func countPairs(nums []int, threshold int) int {
    count := 0
    i := 0
    for i < len(nums)-1 {
        if nums[i+1]-nums[i] <= threshold {
            count++
            i += 2
        } else {
            i++
        }
    }
    return count
}