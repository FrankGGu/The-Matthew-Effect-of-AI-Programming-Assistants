func maximumGroups(preferences []int) int {
    n := len(preferences)
    preferences = append(preferences, preferences...)
    sort.Ints(preferences)

    count := 0
    sum := 0
    for i := 0; i < 2*n; i++ {
        sum += preferences[i]
        if sum >= (count + 1) * (count + 1 + 1) / 2 {
            count++
            sum = 0
        }
        if count == n {
            break
        }
    }
    return count
}