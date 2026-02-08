package main

func removeSticks(sticks []int) int {
    sort.Ints(sticks)
    res := 0
    for len(sticks) > 1 {
        min := sticks[0]
        newSticks := make([]int, 0)
        for _, s := range sticks {
            if s != min {
                newSticks = append(newSticks, s-min)
            }
        }
        res += len(sticks)
        sticks = newSticks
        sort.Ints(sticks)
    }
    return res
}