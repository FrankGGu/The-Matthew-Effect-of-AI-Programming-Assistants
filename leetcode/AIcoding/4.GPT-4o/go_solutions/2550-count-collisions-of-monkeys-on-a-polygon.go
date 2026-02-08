func monkeyCollision(polygon []int) int {
    n := len(polygon)
    count := 0

    for i := 0; i < n; i++ {
        if polygon[i] == 1 {
            for j := i + 1; j < n && polygon[j] == 0; j++ {
                count++
            }
            if j < n && polygon[j] == 1 {
                count++
            }
        }
    }

    return count
}