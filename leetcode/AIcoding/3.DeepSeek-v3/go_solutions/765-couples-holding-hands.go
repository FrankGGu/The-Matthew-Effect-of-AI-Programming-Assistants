func minSwapsCouples(row []int) int {
    n := len(row)
    pos := make(map[int]int)
    for i, num := range row {
        pos[num] = i
    }
    res := 0
    for i := 0; i < n; i += 2 {
        partner := row[i] ^ 1
        if row[i+1] == partner {
            continue
        }
        res++
        partnerPos := pos[partner]
        row[i+1], row[partnerPos] = row[partnerPos], row[i+1]
        pos[row[partnerPos]] = partnerPos
        pos[row[i+1]] = i + 1
    }
    return res
}