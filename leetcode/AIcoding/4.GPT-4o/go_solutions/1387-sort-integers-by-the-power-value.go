func getKth(ints []int, k int) int {
    sort.Slice(ints, func(i, j int) bool {
        return getPowerValue(ints[i]) < getPowerValue(ints[j]) || (getPowerValue(ints[i]) == getPowerValue(ints[j]) && ints[i] < ints[j])
    })
    return ints[k-1]
}

func getPowerValue(n int) int {
    count := 0
    for n != 1 {
        if n%2 == 0 {
            n /= 2
        } else {
            n = 3*n + 1
        }
        count++
    }
    return count
}

func getKthSmallestPowerValue(lo int, hi int, k int) int {
    ints := make([]int, 0, hi-lo+1)
    for i := lo; i <= hi; i++ {
        ints = append(ints, i)
    }
    return getKth(ints, k)
}