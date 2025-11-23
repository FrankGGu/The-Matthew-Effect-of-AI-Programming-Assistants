func minOperations(nums []int) int {
    operations := 0
    for {
        allZero := true
        for _, num := range nums {
            if num != 0 {
                allZero = false
                break
            }
        }
        if allZero {
            break
        }

        hasEven := false
        for i := range nums {
            if nums[i] % 2 != 0 {
                nums[i]--
                operations++
            }
            if nums[i] > 0 {
                hasEven = true
            }
        }

        if hasEven {
            for i := range nums {
                nums[i] /= 2
            }
            operations++
        }
    }
    return operations
}