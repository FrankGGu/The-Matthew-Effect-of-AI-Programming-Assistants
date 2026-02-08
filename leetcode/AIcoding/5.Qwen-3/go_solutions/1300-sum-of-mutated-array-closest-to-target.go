package main

func findBestValue(nums []int, target int) int {
    sort.Ints(nums)
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }
    left, right := 0, nums[n-1]
    var res int
    minDiff := math.MaxInt32
    for left <= right {
        mid := (left + right) / 2
        sum := 0
        for i := 0; i < n; i++ {
            if nums[i] < mid {
                sum += nums[i]
            } else {
                sum += mid
            }
        }
        diff := abs(sum - target)
        if diff < minDiff || (diff == minDiff && mid < res) {
            minDiff = diff
            res = mid
        }
        if sum < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}