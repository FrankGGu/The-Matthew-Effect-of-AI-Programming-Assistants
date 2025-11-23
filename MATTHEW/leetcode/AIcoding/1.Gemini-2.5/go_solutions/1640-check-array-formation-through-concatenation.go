func canFormArray(arr []int, pieces [][]int) bool {
    pieceMap := make(map[int][]int)
    for _, piece := range pieces {
        pieceMap[piece[0]] = piece
    }

    i := 0
    for i < len(arr) {
        currentNum := arr[i]

        piece, found := pieceMap[currentNum]
        if !found {
            return false
        }

        for j := 0; j < len(piece); j++ {
            if arr[i+j] != piece[j] {
                return false
            }
        }

        i += len(piece)
    }

    return true
}