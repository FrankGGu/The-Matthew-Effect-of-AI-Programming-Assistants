func arrayChange(nums []int, operations [][]int) []int {
    indexMap := make(map[int]int)
    for i, num := range nums {
        indexMap[num] = i
    }

    for _, op := range operations {
        oldVal := op[0]
        newVal := op[1]
        if idx, found := indexMap[oldVal]; found {
            nums[idx] = newVal
            delete(indexMap, oldVal)
            indexMap[newVal] = idx
        }
    }

    return nums
}