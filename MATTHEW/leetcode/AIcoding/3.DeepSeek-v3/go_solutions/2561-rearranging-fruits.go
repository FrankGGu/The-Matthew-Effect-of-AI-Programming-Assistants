func minCost(basket1 []int, basket2 []int) int64 {
    freq := make(map[int]int)
    for _, num := range basket1 {
        freq[num]++
    }
    for _, num := range basket2 {
        freq[num]--
    }

    swaps := make([]int, 0)
    for num, cnt := range freq {
        if cnt%2 != 0 {
            return -1
        }
        absCnt := abs(cnt) / 2
        for i := 0; i < absCnt; i++ {
            swaps = append(swaps, num)
        }
    }

    sort.Ints(swaps)
    minVal := swaps[0]
    for _, num := range basket1 {
        if num < minVal {
            minVal = num
        }
    }
    for _, num := range basket2 {
        if num < minVal {
            minVal = num
        }
    }

    var res int64 = 0
    for i := 0; i < len(swaps)/2; i++ {
        res += int64(min(swaps[i], 2*minVal))
    }

    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}