package main

func numEquivDominoPairs(nums [][]int) int {
    count := make(map[string]int)
    result := 0
    for _, domino := range nums {
        key := ""
        if domino[0] < domino[1] {
            key = fmt.Sprintf("%d,%d", domino[0], domino[1])
        } else {
            key = fmt.Sprintf("%d,%d", domino[1], domino[0])
        }
        result += count[key]
        count[key]++
    }
    return result
}