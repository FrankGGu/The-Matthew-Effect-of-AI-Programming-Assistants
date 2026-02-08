func closestEqualElements(arr []int, queries []int) []int {
    pos := make(map[int][]int)
    for i, num := range arr {
        pos[num] = append(pos[num], i)
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        indices, exists := pos[q]
        if !exists {
            res[i] = -1
            continue
        }
        idx := sort.Search(len(indices), func(j int) bool {
            return indices[j] >= i
        })
        minDist := -1
        if idx < len(indices) {
            minDist = indices[idx] - i
        }
        if idx > 0 {
            dist := i - indices[idx-1]
            if minDist == -1 || dist < minDist {
                minDist = dist
            }
        }
        if minDist != -1 {
            res[i] = i + minDist
        } else {
            res[i] = -1
        }
    }
    return res
}