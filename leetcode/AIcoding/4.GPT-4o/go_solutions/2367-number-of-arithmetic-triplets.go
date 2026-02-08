func countArithmeticTriplets(nums []int, diff int) int {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        numSet[num] = struct{}{}
    }

    count := 0
    for _, num := range nums {
        if _, found1 := numSet[num+diff]; found1 {
            if _, found2 := numSet[num+2*diff]; found2 {
                count++
            }
        }
    }

    return count
}