package main

func average(salary []int) float64 {
    min := salary[0]
    max := salary[0]
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
    return float64(sum - min - max) / float64(len(salary)-2)
}