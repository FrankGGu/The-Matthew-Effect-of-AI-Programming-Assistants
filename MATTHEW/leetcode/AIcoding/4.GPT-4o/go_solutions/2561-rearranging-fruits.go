func rearrangeFruits(fruits []int) []int {
    n := len(fruits)
    if n == 0 {
        return fruits
    }

    result := make([]int, n)
    count := make(map[int]int)

    for _, fruit := range fruits {
        count[fruit]++
    }

    type pair struct {
        fruit int
        cnt   int
    }

    pairs := make([]pair, 0, len(count))
    for fruit, cnt := range count {
        pairs = append(pairs, pair{fruit, cnt})
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].cnt > pairs[j].cnt
    })

    index := 0
    for _, p := range pairs {
        for i := 0; i < p.cnt; i++ {
            result[index] = p.fruit
            index++
        }
    }

    return result
}