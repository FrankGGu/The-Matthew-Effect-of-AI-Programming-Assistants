func flowerGame(A []int, B []int) string {
    scoreA, scoreB := 0, 0
    for i := 0; i < len(A); i++ {
        if A[i] > B[i] {
            scoreA++
        } else if B[i] > A[i] {
            scoreB++
        }
    }
    if scoreA > scoreB {
        return "Alice"
    } else if scoreB > scoreA {
        return "Bob"
    } else {
        return "Tie"
    }
}