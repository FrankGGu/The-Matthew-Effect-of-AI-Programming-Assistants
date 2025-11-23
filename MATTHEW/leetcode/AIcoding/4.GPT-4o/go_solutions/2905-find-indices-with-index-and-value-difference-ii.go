func findIndices(nums []int, diff int) []int {
    indexMap := make(map[int]int)
    for i, num := range nums {
        if j, ok := indexMap[num-diff]; ok {
            return []int{j, i}
        }
        if j, ok := indexMap[num+diff]; ok {
            return []int{j, i}
        }
        indexMap[num] = i
    }
    return []int{}
}