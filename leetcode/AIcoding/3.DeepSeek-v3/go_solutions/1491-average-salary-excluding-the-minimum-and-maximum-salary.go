func average(salary []int) float64 {
    min, max := salary[0], salary[0]
    sum := 0
    for _, s := range salary {
        if s < min {
            min = s
        }
        if s > max {
            max = s
        }
        sum += s
    }
    sum = sum - min - max
    return float64(sum) / float64(len(salary)-2)
}