func maxMovesToKill(pawns []int, knights []int) int {
    sort.Ints(pawns)
    sort.Ints(knights)
    ans := 0
    i := 0
    for j := 0; j < len(knights); j++ {
        for i < len(pawns) && pawns[i] < knights[j] {
            i++
        }
        if i < len(pawns) {
            ans++
            i++
        } else {
            break
        }
    }
    return ans
}