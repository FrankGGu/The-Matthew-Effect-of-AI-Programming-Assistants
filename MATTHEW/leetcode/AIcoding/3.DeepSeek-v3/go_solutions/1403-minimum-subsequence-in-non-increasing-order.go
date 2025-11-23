func minSubsequence(nums []int) []int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    sort.Sort(sort.Reverse(sort.IntSlice(nums)))
    currentSum := 0
    result := []int{}
    for _, num := range nums {
        currentSum += num
        result = append(result, num)
        if currentSum > sum - currentSum {
            break
        }
    }
    return result
}