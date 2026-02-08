func minTotalDistance(A [][]int) int {
    var xs, ys []int
    for _, row := range A {
        for _, val := range row {
            if val == 1 {
                xs = append(xs, row[0])
                ys = append(ys, row[1])
            }
        }
    }

    return distance(xs) + distance(ys)
}

func distance(arr []int) int {
    sort.Ints(arr)
    n := len(arr)
    median := arr[n/2]
    total := 0
    for _, val := range arr {
        total += abs(val - median)
    }
    return total
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}