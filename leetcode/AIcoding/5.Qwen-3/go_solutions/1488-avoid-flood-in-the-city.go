package main

func avoidFlood rains []int) []int {
    n := len(rains)
    res := make([]int, n)
    for i := range res {
        res[i] = 1
    }

    lastRain := make(map[int]int)
    unavailable := make(map[int]bool)

    for i, rain := range rains {
        if rain == 0 {
            continue
        }

        if prev, ok := lastRain[rain]; ok {
            for j := prev + 1; j < i; j++ {
                if rains[j] == 0 {
                    res[j] = rain
                    unavailable[rain] = true
                    break
                }
            }
            if !unavailable[rain] {
                return []int{}
            }
        }

        lastRain[rain] = i
        unavailable[rain] = false
    }

    return res
}