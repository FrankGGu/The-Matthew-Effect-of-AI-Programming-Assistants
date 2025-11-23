func twoEditWords(queries []string, dictionary []string) []string {
    result := []string{}
    for _, q := range queries {
        for _, d := range dictionary {
            if isWithinTwoEdits(q, d) {
                result = append(result, q)
                break
            }
        }
    }
    return result
}

func isWithinTwoEdits(q string, d string) bool {
    if len(q) != len(d) {
        return false
    }
    diffCount := 0
    for i := 0; i < len(q); i++ {
        if q[i] != d[i] {
            diffCount++
            if diffCount > 2 {
                return false
            }
        }
    }
    return diffCount <= 2
}