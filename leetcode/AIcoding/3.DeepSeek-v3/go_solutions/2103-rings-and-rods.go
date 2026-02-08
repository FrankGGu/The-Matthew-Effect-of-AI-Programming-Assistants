func countPoints(rings string) int {
    rods := make([]map[byte]bool, 10)
    for i := range rods {
        rods[i] = make(map[byte]bool)
    }

    for i := 0; i < len(rings); i += 2 {
        color := rings[i]
        rod := rings[i+1] - '0'
        rods[rod][color] = true
    }

    count := 0
    for _, colors := range rods {
        if len(colors) == 3 {
            count++
        }
    }
    return count
}