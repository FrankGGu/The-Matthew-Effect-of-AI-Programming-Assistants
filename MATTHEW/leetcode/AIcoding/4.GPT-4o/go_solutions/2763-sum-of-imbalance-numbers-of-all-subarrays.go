func sumOfImbalanceNumbers(nums []int) int64 {
    n := len(nums)
    total := int64(0)
    for i := 0; i < n; i++ {
        leftCount := make(map[int]int)
        rightCount := make(map[int]int)
        for j := i; j < n; j++ {
            if j > i {
                rightCount[nums[j-1]]++
            }
            leftCount[nums[j]]++
            imbalance := 0
            for k := range leftCount {
                if _, exists := rightCount[k]; !exists {
                    imbalance++
                }
            }
            for k := range rightCount {
                if _, exists := leftCount[k]; !exists {
                    imbalance++
                }
            }
            total += int64(imbalance)
        }
    }
    return total
}