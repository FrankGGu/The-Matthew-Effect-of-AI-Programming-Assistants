func unhappyFriends(n int, preferences [][]int, pairs [][]int) int {
    pairMap := make(map[int]int)
    for _, pair := range pairs {
        x, y := pair[0], pair[1]
        pairMap[x] = y
        pairMap[y] = x
    }

    prefRank := make([][]int, n)
    for i := 0; i < n; i++ {
        prefRank[i] = make([]int, n)
        for rank, friend := range preferences[i] {
            prefRank[i][friend] = rank
        }
    }

    unhappy := 0
    for x := 0; x < n; x++ {
        y := pairMap[x]
        xPref := preferences[x]
        found := false
        for _, u := range xPref {
            if u == y {
                break
            }
            v := pairMap[u]
            if prefRank[u][x] < prefRank[u][v] {
                found = true
                break
            }
        }
        if found {
            unhappy++
        }
    }
    return unhappy
}