func arrayChange(nums []int, operations [][]int) []int {
    indexMap := make(map[int]int)
    for i, num := range nums {
        indexMap[num] = i
    }

    for _, op := range operations {
        oldNum, newNum := op[0], op[1]
        if idx, exists := indexMap[oldNum]; exists {
            nums[idx] = newNum
            indexMap[newNum] = idx
            delete(indexMap, oldNum)
        }
    }

    return nums
}