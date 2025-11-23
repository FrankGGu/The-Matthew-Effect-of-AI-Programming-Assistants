func minSwapsCouples(row []int) int {
    n := len(row)
    pos := make([]int, n)
    for i := 0; i < n; i++ {
        pos[row[i]] = i
    }

    swaps := 0
    for i := 0; i < n; i += 2 {
        p1 := row[i]
        partnerP1 := p1 ^ 1
        p2 := row[i+1]

        if p2 == partnerP1 {
            continue
        }

        idxPartnerP1 := pos[partnerP1]

        row[i+1], row[idxPartnerP1] = row[idxPartnerP1], row[i+1]

        pos[p2] = idxPartnerP1
        pos[partnerP1] = i + 1

        swaps++
    }

    return swaps
}