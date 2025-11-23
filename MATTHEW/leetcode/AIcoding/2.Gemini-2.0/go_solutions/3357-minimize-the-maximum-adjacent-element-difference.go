func minimizeMax(nums []int, p int) int {
    n := len(nums)
    if p == 0 {
        return 0
    }
    sort.Ints(nums)
    low := 0
    high := nums[n-1] - nums[0]
    ans := high

    check := func(mid int) bool {
        count := 0
        i := 0
        for i < n-1 {
            if nums[i+1]-nums[i] <= mid {
                count++
                i += 2
            } else {
                i++
            }
        }
        return count >= p
    }

    for low <= high {
        mid := low + (high-low)/2
        if check(mid) {
            ans = mid
            high = mid - 1
        } else {
            low = mid + 1
        }
    }

    return ans
}