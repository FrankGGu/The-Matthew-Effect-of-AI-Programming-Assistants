package main

func maxSatisfaction(satisfaction []int) int {
    sort.Ints(satisfaction)
    n := len(satisfaction)
    res := 0
    total := 0
    for i := n - 1; i >= 0; i-- {
        if satisfaction[i]+total > 0 {
            total += satisfaction[i]
            res += total
        } else {
            break
        }
    }
    return res
}