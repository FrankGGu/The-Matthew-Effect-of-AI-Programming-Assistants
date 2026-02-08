func mergeTriplets(triplets [][]int, target []int) bool {
    a, b, c := target[0], target[1], target[2]
    x, y, z := 0, 0, 0
    for _, t := range triplets {
        if t[0] <= a && t[1] <= b && t[2] <= c {
            if t[0] == a {
                x = a
            }
            if t[1] == b {
                y = b
            }
            if t[2] == c {
                z = c
            }
        }
    }
    return x == a && y == b && z == c
}