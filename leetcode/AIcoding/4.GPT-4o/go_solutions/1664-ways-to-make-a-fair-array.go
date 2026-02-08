func waysToMakeFair(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    oddSum := make([]int, n+1)
    evenSum := make([]int, n+1)

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            evenSum[i+1] = evenSum[i] + nums[i]
            oddSum[i+1] = oddSum[i]
        } else {
            oddSum[i+1] = oddSum[i] + nums[i]
            evenSum[i+1] = evenSum[i]
        }
    }

    count := 0
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            if oddSum[i] + (evenSum[n] - evenSum[i+1]) == evenSum[i] + (oddSum[n] - oddSum[i+1]) {
                count++
            }
        } else {
            if oddSum[i] + (evenSum[n] - evenSum[i+1]) == evenSum[i] + (oddSum[n] - oddSum[i+1]) {
                count++
            }
        }
    }

    return count
}