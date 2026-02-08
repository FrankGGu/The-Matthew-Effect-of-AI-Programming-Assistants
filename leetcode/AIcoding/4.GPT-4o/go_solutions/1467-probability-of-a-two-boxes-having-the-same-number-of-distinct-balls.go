func getProbability(box1 []int, box2 []int) float64 {
    totalBalls := len(box1) + len(box2)

    countBox1 := make(map[int]int)
    countBox2 := make(map[int]int)

    for _, ball := range box1 {
        countBox1[ball]++
    }

    for _, ball := range box2 {
        countBox2[ball]++
    }

    totalDistinctBalls := len(countBox1) + len(countBox2)

    ways := 0
    for i := 0; i <= totalBalls; i++ {
        if i > len(box1) || i > len(box2) {
            continue
        }
        ways += comb(len(box1), i) * comb(len(box2), totalDistinctBalls-i)
    }

    return float64(ways) / float64(comb(totalBalls, totalDistinctBalls))
}

func comb(n, k int) int {
    if k > n {
        return 0
    }
    if k == 0 || k == n {
        return 1
    }
    k = min(k, n-k)
    res := 1
    for i := 0; i < k; i++ {
        res = res * (n - i) / (i + 1)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}