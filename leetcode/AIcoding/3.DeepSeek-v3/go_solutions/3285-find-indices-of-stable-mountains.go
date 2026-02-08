func findIndices(mountains [][]int) []int {
    n := len(mountains)
    if n == 0 {
        return []int{}
    }

    peaks := make([]int, 0)
    for i := 0; i < n; i++ {
        valid := true
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            if mountains[i][0] <= mountains[j][0] && mountains[i][1] <= mountains[j][1] {
                valid = false
                break
            }
        }
        if valid {
            peaks = append(peaks, i)
        }
    }

    return peaks
}