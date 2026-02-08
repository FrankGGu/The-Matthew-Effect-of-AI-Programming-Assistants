func smallestGoodBase(n string) string {
    num, _ := strconv.ParseInt(n, 10, 64)
    for m := 60; m >= 2; m-- {
        k := int64(math.Pow(float64(num), 1.0/float64(m)))
        if k < 2 {
            continue
        }
        sum := int64(1)
        base := k
        for i := 0; i < m; i++ {
            sum = sum*base + 1
            if sum > num {
                break
            }
        }
        if sum == num {
            return strconv.FormatInt(k, 10)
        }
    }
    return strconv.FormatInt(num-1, 10)
}