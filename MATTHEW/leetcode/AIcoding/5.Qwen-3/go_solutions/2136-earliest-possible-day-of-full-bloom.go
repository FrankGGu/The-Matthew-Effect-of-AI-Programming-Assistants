package main

func earliestDayFullBloom(plantTime []int, growTime []int) int {
    n := len(plantTime)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{plantTime[i], growTime[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][1] > pairs[j][1]
    })
    day := 0
    for _, p := range pairs {
        day += p[0]
        if day > p[1] {
            day = p[1]
        }
    }
    return day
}