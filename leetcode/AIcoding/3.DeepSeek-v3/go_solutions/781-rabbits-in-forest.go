func numRabbits(answers []int) int {
    count := make(map[int]int)
    for _, num := range answers {
        count[num]++
    }
    res := 0
    for num, c := range count {
        groups := (c + num) / (num + 1)
        res += groups * (num + 1)
    }
    return res
}