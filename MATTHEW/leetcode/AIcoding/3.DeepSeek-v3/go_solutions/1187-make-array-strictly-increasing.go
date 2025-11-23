func makeArrayIncreasing(arr1 []int, arr2 []int) int {
    sort.Ints(arr2)
    dp := make(map[int]int)
    dp[-1] = 0

    for _, num := range arr1 {
        newDp := make(map[int]int)
        for key, val := range dp {
            if num > key {
                if v, ok := newDp[num]; !ok || val < v {
                    newDp[num] = val
                }
            }
            idx := sort.SearchInts(arr2, key+1)
            if idx < len(arr2) {
                if v, ok := newDp[arr2[idx]]; !ok || val+1 < v {
                    newDp[arr2[idx]] = val + 1
                }
            }
        }
        if len(newDp) == 0 {
            return -1
        }
        dp = newDp
    }

    minOps := math.MaxInt32
    for _, val := range dp {
        if val < minOps {
            minOps = val
        }
    }
    return minOps
}