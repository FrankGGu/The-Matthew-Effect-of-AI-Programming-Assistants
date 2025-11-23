func minimumSeconds(nums []int) int {
    pos := make(map[int][]int)
    for i, num := range nums {
        pos[num] = append(pos[num], i)
    }

    minTime := math.MaxInt32
    for _, indices := range pos {
        maxGap := 0
        n := len(indices)
        for i := 0; i < n; i++ {
            prev := indices[i]
            next := indices[(i+1)%n]
            gap := (next - prev - 1 + len(nums)) % len(nums)
            if gap > maxGap {
                maxGap = gap
            }
        }
        time := (maxGap + 1) / 2
        if time < minTime {
            minTime = time
        }
    }
    return minTime
}