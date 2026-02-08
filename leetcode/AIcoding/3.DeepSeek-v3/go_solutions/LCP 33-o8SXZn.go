func storeWater(bucket []int, vat []int) int {
    maxK := 0
    for _, v := range vat {
        if v > maxK {
            maxK = v
        }
    }
    if maxK == 0 {
        return 0
    }

    res := math.MaxInt32
    for k := 1; k <= maxK; k++ {
        t := 0
        for i := 0; i < len(bucket); i++ {
            t += max(0, (vat[i]+k-1)/k - bucket[i])
        }
        if t + k < res {
            res = t + k
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}