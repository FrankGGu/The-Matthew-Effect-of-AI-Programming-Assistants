func getSmallestString(s string, k int) string {
    res := []byte(s)
    for i := 0; i < len(res) && k > 0; i++ {
        c := res[i]
        minC := byte('a')
        maxC := byte('z')
        dist1 := int(c - minC)
        dist2 := int(maxC - c + 1)
        minDist := min(dist1, dist2)
        if k >= minDist {
            k -= minDist
            if dist1 < dist2 {
                res[i] = minC
            } else {
                res[i] = minC
            }
        } else {
            res[i] -= byte(k)
            k = 0
        }
    }
    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}