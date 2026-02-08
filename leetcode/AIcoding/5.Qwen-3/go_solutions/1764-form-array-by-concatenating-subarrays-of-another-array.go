package main

func canFormArray(arr []int, pieces [][]int) bool {
    pieceMap := make(map[int][]int)
    for _, piece := range pieces {
        pieceMap[piece[0]] = piece
    }

    i := 0
    for i < len(arr) {
        if piece, ok := pieceMap[arr[i]]; ok {
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