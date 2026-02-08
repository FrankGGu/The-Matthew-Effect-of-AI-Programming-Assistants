func maxIncreasingGroups(usageLimits []int) int {
    sort.Ints(usageLimits)
    total, count := 0, 0
    for _, num := range usageLimits {
        total += num
        if total >= (count+1)*(count+2)/2 {
            count++
        }
    }
    return count
}