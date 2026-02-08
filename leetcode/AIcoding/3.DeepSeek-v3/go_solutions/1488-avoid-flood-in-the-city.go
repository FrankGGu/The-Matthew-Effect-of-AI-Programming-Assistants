func avoidFlood(rains []int) []int {
    n := len(rains)
    res := make([]int, n)
    for i := range res {
        res[i] = 1
    }
    lakeToDay := make(map[int]int)
    dryDays := make([]int, 0)

    for day, lake := range rains {
        if lake == 0 {
            dryDays = append(dryDays, day)
            continue
        }
        res[day] = -1
        if lastDay, exists := lakeToDay[lake]; exists {
            found := -1
            for i, dryDay := range dryDays {
                if dryDay > lastDay {
                    found = i
                    break
                }
            }
            if found == -1 {
                return []int{}
            }
            res[dryDays[found]] = lake
            dryDays = append(dryDays[:found], dryDays[found+1:]...)
        }
        lakeToDay[lake] = day
    }
    return res
}