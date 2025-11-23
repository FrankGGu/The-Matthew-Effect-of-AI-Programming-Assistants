package main

func numRabbits(answers []int) int {
    m := make(map[int]int)
    for _, ans := range answers {
        m[ans]++
    }
    res := 0
    for k, v := range m {
        if k == 0 {
            res += v
            continue
        }
        groups := v / (k + 1)
        remainder := v % (k + 1)
        if remainder != 0 {
            groups++
        }
        res += groups * (k + 1)
    }
    return res
}