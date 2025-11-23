func countPoints(rings string) int {
    rods := make(map[int]string)
    for i := 0; i < len(rings); i += 2 {
        color := string(rings[i])
        rod := int(rings[i+1] - '0')
        rods[rod] += color
    }

    count := 0
    for _, colors := range rods {
        if strings.Contains(colors, "R") && strings.Contains(colors, "G") && strings.Contains(colors, "B") {
            count++
        }
    }

    return count
}