package main

func sampleStats(mean []float64, count []int) []float64 {
    var meanValue float64
    var mode int
    var median float64
    var maxCount int
    var totalCount int
    var sum float64
    var freqMap map[int]int
    freqMap = make(map[int]int)
    for i := 0; i < len(count); i++ {
        if count[i] > 0 {
            freqMap[i] = count[i]
            sum += float64(i)*float64(count[i])
            totalCount += count[i]
        }
    }
    meanValue = sum / float64(totalCount)
    maxCount = 0
    for key, value := range freqMap {
        if value > maxCount {
            maxCount = value
            mode = key
        }
    }
    var sortedValues []int
    for i := 0; i < len(count); i++ {
        for j := 0; j < count[i]; j++ {
            sortedValues = append(sortedValues, i)
        }
    }
    if len(sortedValues)%2 == 1 {
        median = float64(sortedValues[len(sortedValues)/2])
    } else {
        median = float64(sortedValues[len(sortedValues)/2-1]+sortedValues[len(sortedValues)/2]) / 2
    }
    return []float64{meanValue, float64(mode), median}
}