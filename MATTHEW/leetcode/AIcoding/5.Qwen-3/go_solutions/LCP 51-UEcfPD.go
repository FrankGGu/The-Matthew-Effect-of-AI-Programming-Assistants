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
        groupSize := k + 1
        fullGroups := v / groupSize
        remainder := v % groupSize
        if remainder > 0 {
            fullGroups++
        }
        res += fullGroups * groupSize
    }
    return res
}