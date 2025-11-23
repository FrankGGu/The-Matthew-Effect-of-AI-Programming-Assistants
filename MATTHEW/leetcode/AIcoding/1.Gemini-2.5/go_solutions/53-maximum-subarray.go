func maxSubArray(nums []int) int {
    if len(nums) == 0 {
        return 0 // Or handle error, though problem constraints say len >= 1
    }

    maxSoFar := nums[0]
    currentMax := nums[0]

    for i := 1; i < len(nums); i++ {
        num := nums[i]

        // currentMax = max(num, currentMax + num)
        if num > currentMax + num {
            currentMax = num
        } else {
            currentMax = currentMax + num
        }

        // maxSoFar = max(maxSoFar, currentMax)
        if currentMax > maxSoFar {
            maxSoFar = currentMax
        }
    }

    return maxSoFar
}