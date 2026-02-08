package main

func smallestDistancePair(nums []int, k int) int {
    sort.Ints(nums)
    n := len(nums)
    left, right := 0, nums[n-1]-nums[0]
    for left < right {
        mid := left + (right-left)/2
        count := 0
        j := 0
        for i := 0; i < n; i++ {
            for j < n && nums[j]-nums[i] <= mid {
                j++
            }
            count += j - i - 1
        }
        if count >= k {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}