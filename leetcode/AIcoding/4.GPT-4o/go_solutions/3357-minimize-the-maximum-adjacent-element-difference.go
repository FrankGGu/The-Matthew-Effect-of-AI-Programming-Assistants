func minimizeMax(nums []int, p int) int {
    n := len(nums)
    sort.Ints(nums)

    low, high := 0, nums[n-1]-nums[0]
    for low < high {
        mid := low + (high-low)/2
        if canFormPairs(nums, mid, p) {
            high = mid
        } else {
            low = mid + 1
        }
    }
    return low
}

func canFormPairs(nums []int, maxDiff int, p int) bool {
    count := 0
    i := 0
    for i < len(nums)-1 {
        if nums[i+1]-nums[i] <= maxDiff {
            count++
            i += 2
        } else {
            i++
        }
    }
    return count >= p
}