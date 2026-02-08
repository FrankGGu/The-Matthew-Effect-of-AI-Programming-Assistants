func mergeArrays(nums1 [][]int, nums2 [][]int) [][]int {
    m := make(map[int]int)
    for _, num := range nums1 {
        id, val := num[0], num[1]
        m[id] += val
    }
    for _, num := range nums2 {
        id, val := num[0], num[1]
        m[id] += val
    }
    keys := make([]int, 0, len(m))
    for k := range m {
        keys = append(keys, k)
    }
    sort.Ints(keys)
    res := make([][]int, len(keys))
    for i, k := range keys {
        res[i] = []int{k, m[k]}
    }
    return res
}