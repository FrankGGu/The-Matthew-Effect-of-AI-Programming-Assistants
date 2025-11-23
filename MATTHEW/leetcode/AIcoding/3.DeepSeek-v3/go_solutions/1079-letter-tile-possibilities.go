func numTilePossibilities(tiles string) int {
    count := make([]int, 26)
    for _, c := range tiles {
        count[c-'A']++
    }
    return dfs(count)
}

func dfs(count []int) int {
    sum := 0
    for i := 0; i < 26; i++ {
        if count[i] == 0 {
            continue
        }
        sum++
        count[i]--
        sum += dfs(count)
        count[i]++
    }
    return sum
}