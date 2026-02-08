func average(salary []int) float64 {
    minSalary, maxSalary, total := salary[0], salary[0], 0
    for _, s := range salary {
        if s < minSalary {
            minSalary = s
        }
        if s > maxSalary {
            maxSalary = s
        }
        total += s
    }
    return float64(total-minSalary-maxSalary) / float64(len(salary)-2)
}