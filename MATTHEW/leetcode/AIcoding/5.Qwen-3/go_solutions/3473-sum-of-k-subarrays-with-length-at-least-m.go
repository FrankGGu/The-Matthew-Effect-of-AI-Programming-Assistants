package main

func kSubarrays(nums []int, k int, m int) int {
    n := len(nums)
    if k*m > n {
        return 0
    }

    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    sumMap := make(map[int]int)
    res := 0

    for i := 0; i <= n-m; i++ {
        currentSum := prefix[i+m] - prefix[i]
        sumMap[currentSum]++
    }

    for i := 0; i <= n-m; i++ {
        currentSum := prefix[i+m] - prefix[i]
        sumMap[currentSum]--
        if sumMap[currentSum] == 0 {
            delete(sumMap, currentSum)
        }

        if len(sumMap) >= k {
            res += 1
        }
    }

    return res
}