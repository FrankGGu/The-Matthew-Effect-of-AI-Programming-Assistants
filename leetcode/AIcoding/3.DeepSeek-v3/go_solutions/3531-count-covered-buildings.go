func countBuildings(buildings [][]int) int {
    if len(buildings) == 0 {
        return 0
    }

    sort.Slice(buildings, func(i, j int) bool {
        if buildings[i][0] == buildings[j][0] {
            return buildings[i][1] > buildings[j][1]
        }
        return buildings[i][0] < buildings[j][0]
    })

    count := 1
    prev := buildings[0]

    for i := 1; i < len(buildings); i++ {
        current := buildings[i]
        if current[1] > prev[1] {
            count++
            prev = current
        }
    }

    return count
}