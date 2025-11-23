func smallestDistancePair(nums []int, k int) int {
    sort.Ints(nums)
    left, right := 0, nums[len(nums)-1]-nums[0]

    for left < right {
        mid := left + (right-left)/2
        if countPairs(nums, mid) < k {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left
}

func countPairs(nums []int, mid int) int {
    count, j := 0, 0
    for i := 0; i < len(nums); i++ {
        for j < len(nums) && nums[j]-nums[i] <= mid {
            j++
        }
        count += j - i - 1
    }
    return count
}