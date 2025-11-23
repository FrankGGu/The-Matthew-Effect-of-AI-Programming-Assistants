func findDifference(nums []int) [][]int {
    result := [][]int{}
    indexMap := make(map[int][]int)

    for i, num := range nums {
        indexMap[num] = append(indexMap[num], i)
    }

    for num, indices := range indexMap {
        for _, idx := range indices {
            if num-idx == 0 {
                continue
            }
            result = append(result, []int{idx, num - idx})
        }
    }

    return result
}