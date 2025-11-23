func canFormArray(arr []int, pieces [][]int) bool {
    pieceMap := make(map[int][]int)
    for _, piece := range pieces {
        pieceMap[piece[0]] = piece
    }

    i := 0
    for i < len(arr) {
        first := arr[i]
        if piece, exists := pieceMap[first]; exists {
            for j := 0; j < len(piece); j++ {
                if i >= len(arr) || arr[i] != piece[j] {
                    return false
                }
                i++
            }
        } else {
            return false
        }
    }
    return true
}