func maxHammerHits(time []int) int {
    if len(time) == 0 {
        return 0
    }
    sort.Ints(time)
    maxHits := 1
    currentHits := 1
    for i := 1; i < len(time); i++ {
        if time[i] - time[i-1] <= 1 {
            currentHits++
            if currentHits > maxHits {
                maxHits = currentHits
            }
        } else {
            currentHits = 1
        }
    }
    return maxHits
}