package main

func maximumBags(capacity []int, rocks []int, additionalRocks int) int {
    diff := make([]int, len(capacity))
    for i := range capacity {
        diff[i] = capacity[i] - rocks[i]
    }
    sort.Ints(diff)
    count := 0
    for _, d := range diff {
        if d <= 0 {
            count++
        } else if additionalRocks >= d {
            additionalRocks -= d
            count++
        }
    }
    return count
}