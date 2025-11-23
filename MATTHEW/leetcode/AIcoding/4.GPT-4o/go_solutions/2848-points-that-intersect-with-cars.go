func countPoints(points [][]int, cars [][]int) []int {
    result := make([]int, len(cars))

    for i, car := range cars {
        cx, cy, cr := car[0], car[1], car[2]
        count := 0

        for _, point := range points {
            px, py := point[0], point[1]
            if (px-cx)*(px-cx)+(py-cy)*(py-cy) <= cr*cr {
                count++
            }
        }

        result[i] = count
    }

    return result
}