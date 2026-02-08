import "sort"

func minCost(nums []int, cost []int) int64 {
    n := len(nums)
    arr := make([]int, n)
    for i := 0; i < n; i++ {
        arr[i] = nums[i]
    }
    sort.Ints(arr)

    ans := int64(1e18)

    check := func(x int) int64 {
        res := int64(0)
        for i := 0; i < n; i++ {
            diff := abs(nums[i] - x)
            res += int64(diff) * int64(cost[i])
        }
        return res
    }

    l, r := arr[0], arr[n-1]
    for l <= r {
        mid1 := l + (r-l)/3
        mid2 := r - (r-l)/3
        cost1 := check(mid1)
        cost2 := check(mid2)

        if cost1 < cost2 {
            ans = min(ans, cost1)
            r = mid2 - 1
        } else {
            ans = min(ans, cost2)
            l = mid1 + 1
        }
    }
    return ans
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}