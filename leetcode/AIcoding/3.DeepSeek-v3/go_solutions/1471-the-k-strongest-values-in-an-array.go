func getStrongest(arr []int, k int) []int {
    n := len(arr)
    if n == 0 {
        return []int{}
    }
    sort.Ints(arr)
    median := arr[(n-1)/2]

    type pair struct {
        val int
        diff int
    }
    pairs := make([]pair, n)
    for i, num := range arr {
        pairs[i] = pair{num, abs(num - median)}
    }

    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].diff == pairs[j].diff {
            return pairs[i].val > pairs[j].val
        }
        return pairs[i].diff > pairs[j].diff
    })

    res := make([]int, k)
    for i := 0; i < k; i++ {
        res[i] = pairs[i].val
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}