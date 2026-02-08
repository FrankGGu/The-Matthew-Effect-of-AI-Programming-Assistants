func findLHS(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    maxLen := 0
    for num, c := range count {
        if _, ok := count[num+1]; ok {
            if c+count[num+1] > maxLen {
                maxLen = c + count[num+1]
            }
        }
    }
    return maxLen
}