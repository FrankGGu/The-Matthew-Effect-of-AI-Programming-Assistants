func longestEqualSubarray(nums []int, k int) int {
    pos := make(map[int][]int)
    for i, num := range nums {
        pos[num] = append(pos[num], i)
    }
    maxLen := 0
    for _, indices := range pos {
        left := 0
        for right := range indices {
            for (indices[right] - indices[left] + 1) - (right - left + 1) > k {
                left++
            }
            if right - left + 1 > maxLen {
                maxLen = right - left + 1
            }
        }
    }
    return maxLen
}