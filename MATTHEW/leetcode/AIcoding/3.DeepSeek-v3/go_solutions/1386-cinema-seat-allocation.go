func maxNumberOfFamilies(n int, reservedSeats [][]int) int {
    reserved := make(map[int]map[byte]bool)
    for _, seat := range reservedSeats {
        row, col := seat[0], seat[1]
        if reserved[row] == nil {
            reserved[row] = make(map[byte]bool)
        }
        reserved[row][byte(col)] = true
    }

    res := 2 * (n - len(reserved))
    for _, cols := range reserved {
        canFit := 0
        if !cols[2] && !cols[3] && !cols[4] && !cols[5] {
            canFit++
        }
        if !cols[6] && !cols[7] && !cols[8] && !cols[9] {
            canFit++
        }
        if canFit == 0 && !cols[4] && !cols[5] && !cols[6] && !cols[7] {
            canFit++
        }
        res += canFit
    }
    return res
}