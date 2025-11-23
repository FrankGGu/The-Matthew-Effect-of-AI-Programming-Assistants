package main

func maxSumTwoNoOverlap(nums []int, firstLen int, secondLen int) int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    getSum := func(i, j int) int {
        return prefix[j] - prefix[i]
    }

    maxSum := 0

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if j-i >= firstLen && j-i >= secondLen {
                sum1 := getSum(i, i+firstLen)
                sum2 := getSum(j, j+secondLen)
                maxSum = max(maxSum, sum1+sum2)
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if j-i >= secondLen && j-i >= firstLen {
                sum1 := getSum(i, i+secondLen)
                sum2 := getSum(j, j+firstLen)
                maxSum = max(maxSum, sum1+sum2)
            }
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}