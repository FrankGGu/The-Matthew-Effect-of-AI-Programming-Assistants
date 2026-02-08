func avoidFlood(rains []int) []int {
    n := len(rains)
    ans := make([]int, n)
    dryDays := []int{}
    lakes := make(map[int]int)

    for i := 0; i < n; i++ {
        if rains[i] > 0 {
            if _, ok := lakes[rains[i]]; ok {
                return []int{}
            }
            lakes[rains[i]] = i
            ans[i] = -1
        } else {
            dryDays = append(dryDays, i)
            ans[i] = 1
        }
    }

    for _, i := range dryDays {
        if len(dryDays) > 0 {
            lakeToDrain := -1
            for lake, lastRainIndex := range lakes {
                if lastRainIndex < i {
                    lakeToDrain = lake
                    break
                }
            }
            if lakeToDrain != -1 {
                ans[i] = lakeToDrain
                delete(lakes, lakeToDrain)
            }
        }
    }

    return ans
}