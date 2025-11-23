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

        for i := 0; i < len(nums); i++ {
            if nums[i] % 2 != 0 {
                nums[i]--
                operations++
            }
        }

        allZero = true
        for _, num := range nums {
            if num != 0 {
                allZero = false
                break
            }
        }
        if allZero {
            break
        }

        for i := 0; i < len(nums); i++ {
            nums[i] /= 2
        }
        operations++
    }
    return operations
}