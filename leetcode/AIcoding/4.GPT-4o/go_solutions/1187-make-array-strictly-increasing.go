func makeArrayIncreasing(arr1 []int, arr2 []int) int {
    sort.Ints(arr2)
    dp := map[int]int{0: 0}

    for _, a := range arr1 {
        next := map[int]int{}
        for prev, steps := range dp {
            if a > prev {
                next[a] = min(next[a], steps) // keep the current element
            }
            idx := sort.Search(len(arr2), func(i int) bool { return arr2[i] > prev })
            if idx < len(arr2) {
                next[arr2[idx]] = min(next[arr2[idx]], steps+1) // replace with arr2[idx]
            }
        }
        dp = next
    }

    res := math.MaxInt32
    for _, steps := range dp {
        res = min(res, steps)
    }

    if res == math.MaxInt32 {
        return -1
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}