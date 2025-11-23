func maxAlternatingSum(nums []int) int64 {
    if len(nums) == 0 {
        return 0
    }

    evenSum, oddSum := int64(0), int64(0)
    currentSum := int64(0)
    sign := 1

    for i := 0; i < len(nums); i++ {
        currentSum += int64(nums[i]) * int64(sign)
        if i == len(nums)-1 || (i < len(nums)-1 && nums[i] >= nums[i+1]) {
            if sign == 1 {
                evenSum += currentSum
            } else {
                oddSum += currentSum
            }
            currentSum = 0
            sign = -sign
        }
    }

    return evenSum - oddSum
}