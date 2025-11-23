func minimalKSum(nums []int, k int) int64 {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        if num > 0 {
            numSet[num] = struct{}{}
        }
    }

    var sum int64 = 0
    for i, count := 1, 0; count < k; i++ {
        if _, exists := numSet[i]; !exists {
            sum += int64(i)
            count++
        }
    }

    return sum
}