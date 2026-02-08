package main

func leftRigthDifference(nums []int) []int {
    n := len(nums)
    leftSum := make([]int, n)
    rightSum := make([]int, n)

    for i := 1; i < n; i++ {
        leftSum[i] = leftSum[i-1] + nums[i-1]
    }

    for i := n - 2; i >= 0; i-- {
        rightSum[i] = rightSum[i+1] + nums[i+1]
    }

    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = abs(leftSum[i] - rightSum[i])
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}