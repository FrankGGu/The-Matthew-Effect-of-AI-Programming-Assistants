func minDominoRotations(tops []int, bottoms []int) int {
    n := len(tops)
    countA := make([]int, 7)
    countB := make([]int, 7)
    same := make([]int, 7)

    for i := 0; i < n; i++ {
        a, b := tops[i], bottoms[i]
        countA[a]++
        countB[b]++
        if a == b {
            same[a]++
        }
    }

    for x := 1; x <= 6; x++ {
        if countA[x] + countB[x] - same[x] >= n {
            return min(n - countA[x], n - countB[x])
        }
    }

    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}