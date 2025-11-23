func countCompleteDayPairs(hours []int) int {
    count := 0
    freq := [24]int{} 

    for _, hour := range hours {
        rem := hour % 24

        complementRem := (24 - rem) % 24

        count += freq[complementRem]

        freq[rem]++
    }

    return count
}