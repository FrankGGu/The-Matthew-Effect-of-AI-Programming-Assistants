func waysToMakeFair(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    leftEven := make([]int, n)
    leftOdd := make([]int, n)
    rightEven := make([]int, n)
    rightOdd := make([]int, n)

    leftEven[0] = nums[0]
    leftOdd[0] = 0
    for i := 1; i < n; i++ {
        if i%2 == 0 {
            leftEven[i] = leftEven[i-1] + nums[i]
            leftOdd[i] = leftOdd[i-1]
        } else {
            leftOdd[i] = leftOdd[i-1] + nums[i]
            leftEven[i] = leftEven[i-1]
        }
    }

    if (n-1)%2 == 0 {
        rightEven[n-1] = nums[n-1]
        rightOdd[n-1] = 0
    } else {
        rightOdd[n-1] = nums[n-1]
        rightEven[n-1] = 0
    }
    for i := n-2; i >= 0; i-- {
        if i%2 == 0 {
            rightEven[i] = rightEven[i+1] + nums[i]
            rightOdd[i] = rightOdd[i+1]
        } else {
            rightOdd[i] = rightOdd[i+1] + nums[i]
            rightEven[i] = rightEven[i+1]
        }
    }

    res := 0
    for i := 0; i < n; i++ {
        var evenSum, oddSum int
        if i == 0 {
            evenSum = rightOdd[i+1]
            oddSum = rightEven[i+1]
        } else if i == n-1 {
            evenSum = leftEven[i-1]
            oddSum = leftOdd[i-1]
        } else {
            evenSum = leftEven[i-1] + rightOdd[i+1]
            oddSum = leftOdd[i-1] + rightEven[i+1]
        }
        if evenSum == oddSum {
            res++
        }
    }
    return res
}