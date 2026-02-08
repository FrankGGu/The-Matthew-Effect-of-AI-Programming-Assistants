func sampleStats(count []int) []float64 {
    min, max, total, totalCount := -1.0, -1.0, 0.0, 0
    mode, maxCount := -1.0, 0

    for i := 0; i < 256; i++ {
        if count[i] > 0 {
            if min == -1 {
                min = float64(i)
            }
            max = float64(i)
            total += float64(i) * float64(count[i])
            totalCount += count[i]
            if count[i] > maxCount {
                maxCount = count[i]
                mode = float64(i)
            }
        }
    }

    mean := total / totalCount
    median := 0.0
    cumulative := 0

    for i := 0; i < 256; i++ {
        cumulative += count[i]
        if cumulative >= (totalCount+1)/2 && median == 0.0 {
            median = float64(i)
        }
        if cumulative >= totalCount/2 && median != 0.0 {
            median = (median + float64(i)) / 2
            break
        }
    }

    return []float64{min, max, mean, median, mode}
}