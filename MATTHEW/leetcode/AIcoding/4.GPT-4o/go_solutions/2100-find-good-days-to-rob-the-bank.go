func goodDaysToRobBank(security []int, time int) []int {
    n := len(security)
    if n == 0 || time == 0 {
        return []int{}
    }

    nonIncreasing := make([]int, n)
    for i := 1; i < n; i++ {
        if security[i] <= security[i-1] {
            nonIncreasing[i] = nonIncreasing[i-1] + 1
        }
    }

    goodDays := []int{}
    for i := time; i <= n-time-1; i++ {
        if nonIncreasing[i] >= time && nonIncreasing[i+time] >= time {
            goodDays = append(goodDays, i)
        }
    }

    return goodDays
}