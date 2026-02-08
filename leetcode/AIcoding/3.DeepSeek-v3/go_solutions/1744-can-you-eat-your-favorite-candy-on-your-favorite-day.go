func canEat(candiesCount []int, queries [][]int) []bool {
    n := len(candiesCount)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + candiesCount[i]
    }

    res := make([]bool, len(queries))
    for i, q := range queries {
        favType, favDay, dailyCap := q[0], q[1], q[2]
        minCandies := favDay + 1
        maxCandies := (favDay + 1) * dailyCap
        totalBefore := prefix[favType]
        total := prefix[favType+1]

        if minCandies > total || maxCandies <= totalBefore {
            res[i] = false
        } else {
            res[i] = true
        }
    }
    return res
}