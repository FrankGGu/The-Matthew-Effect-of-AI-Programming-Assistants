func numRabbits(answers []int) int {
    count := make(map[int]int)
    for _, ans := range answers {
        count[ans]++
    }
    res := 0
    for k, v := range count {
        groupSize := k + 1
        numGroups := (v + groupSize - 1) / groupSize
        res += numGroups * groupSize
    }
    return res
}