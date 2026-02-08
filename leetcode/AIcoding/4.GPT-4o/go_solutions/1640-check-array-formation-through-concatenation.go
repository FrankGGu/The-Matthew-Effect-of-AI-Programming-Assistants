func canFormArray(arr []int, pieces [][]int) bool {
    indexMap := make(map[int]int)
    for i, piece := range pieces {
        indexMap[piece[0]] = i
    }

    i := 0
    for i < len(arr) {
        if idx, exists := indexMap[arr[i]]; exists {
            piece := pieces[idx]
            for j := 0; j < len(piece); j++ {
                if i < len(arr) && arr[i] == piece[j] {
                    i++
                } else {
                    return false
                }
            }
        } else {
            return false
        }
    }
    return true
}