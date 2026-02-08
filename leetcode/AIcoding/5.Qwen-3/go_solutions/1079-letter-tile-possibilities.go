package main

func numTilePossibilities(tiles string) int {
    count := make([]int, 26)
    for _, c := range tiles {
        count[c-'a']++
    }
    return dfs(count)
}

func dfs(count []int) int {
    res := 0
    for i := 0; i < 26; i++ {
        if count[i] == 0 {
            continue
        }
        count[i]--
        res += 1 + dfs(count)
        count[i]++
    }
    return res
}