func minOperations(nums []int) int {
    operations := 0
    maxDoubles := 0

    for _, num := range nums {
        currentDoubles := 0
        for num > 0 {
            if num%2 == 1 {
                operations++
                num--
            } else {