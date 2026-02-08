func maxSatisfaction(satisfaction []int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(satisfaction)))
    maxSum := 0
    prefixSum := 0
    total := 0
    for _, s := range satisfaction {
        prefixSum += s
        total += prefixSum
        if total > maxSum {
            maxSum = total
        }
    }
    return maxSum
}