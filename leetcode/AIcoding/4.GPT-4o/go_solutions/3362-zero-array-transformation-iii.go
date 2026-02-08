func zerArrayOperations(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    totalSteps := 0
    for maxNum > 0 {
        count := 0
        for _, num := range nums {
            if num > 0 {
                count++
            }
        }
        if count == 0 {
            break
        }
        totalSteps += maxNum
        for i := range nums {
            if nums[i] > 0 {
                nums[i] -= maxNum
            }
        }
        maxNum = 0
        for _, num := range nums {
            if num > maxNum {
                maxNum = num
            }
        }
    }

    return totalSteps
}