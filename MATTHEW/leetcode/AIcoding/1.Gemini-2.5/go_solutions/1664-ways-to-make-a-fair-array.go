func waysToMakeFair(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    prefEven := make([]int, n+1)
    prefOdd := make([]int, n+1)

    for k := 0; k < n; k++ {
        prefEven[k+1] = prefEven[k]
        prefOdd[k+1] = prefOdd[k]
        if k%2 == 0 {
            prefEven[k+1] += nums[k]
        } else {
            prefOdd[k+1] += nums[k]
        }
    }

    count := 0
    for i := 0; i < n; i++ {
        sumEvenLeft := prefEven[i]
        sumOddLeft := prefOdd[i]

        sumEvenRightOriginal := prefEven[n] - prefEven[i+1]
        sumOddRightOriginal := prefOdd[n] - prefOdd[i+1]

        newEvenSum := sumEvenLeft + sumOddRightOriginal
        newOddSum := sumOddLeft + sumEvenRightOriginal

        if newEvenSum == newOddSum {
            count++
        }
    }

    return count
}